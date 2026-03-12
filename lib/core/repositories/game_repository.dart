import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/game_document.dart';
import '../models/game_player.dart';

class GameRepository {
  GameRepository._();

  static final GameRepository instance = GameRepository._();

  static const String gamesCollection = 'games';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Random _random = Random();

  CollectionReference<Map<String, dynamic>> get _games =>
      _firestore.collection(gamesCollection);

  Future<String> createGame({
    required String activityName,
    required int playersCount,
    String? createdBy,
  }) async {
    final now = Timestamp.now();
    final doc = await _games.add(<String, dynamic>{
      'activityName': activityName,
      'playersCount': playersCount,
      'createdBy': createdBy ?? '',
      'status': 'in_progress',
      'stage': 'players_names',
      'currentStep': 1,
      'currentPlayerIndex': 0,
      'currentVotingTurnIndex': 0,
      'winnerAnswer': '',
      'isTie': false,
      'results': <String, int>{},
      'players': <Map<String, dynamic>>[],
      'createdAt': now,
      'updatedAt': now,
      'finishedAt': null,
    });
    return doc.id;
  }

  Future<void> savePlayerNames(String gameId, List<String> playerNames) async {
    final players = List<GamePlayer>.generate(
      playerNames.length,
      (int index) => GamePlayer(
        id: 'p${index + 1}',
        name: playerNames[index],
        answer: '',
        selectedColor: '',
        voteAnswer: '',
      ),
    );

    await _games.doc(gameId).update(<String, dynamic>{
      'players': players.map((player) => player.toMap()).toList(),
      'stage': 'players_answers',
      'currentStep': 2,
      'currentPlayerIndex': 0,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> savePlayerAnswer({
    required String gameId,
    required int playerIndex,
    required String answer,
  }) async {
    final game = await continueGame(gameId);
    final players = List<GamePlayer>.from(game.players);
    players[playerIndex] = players[playerIndex].copyWith(answer: answer);
    final isLastPlayer = playerIndex >= players.length - 1;

    await _games.doc(gameId).update(<String, dynamic>{
      'players': players.map((player) => player.toMap()).toList(),
      'stage': isLastPlayer ? 'ready_to_play' : 'players_answers',
      'currentStep': isLastPlayer ? 3 : 2,
      'currentPlayerIndex': isLastPlayer ? 0 : playerIndex + 1,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> goToReadyStage(String gameId) async {
    await _games.doc(gameId).update(<String, dynamic>{
      'stage': 'ready_to_play',
      'currentStep': 3,
      'currentPlayerIndex': 0,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> startVoting(String gameId) async {
    final game = await continueGame(gameId);
    final players = _assignColors(game.players);
    await _games.doc(gameId).update(<String, dynamic>{
      'players': players.map((player) => player.toMap()).toList(),
      'stage': 'voting',
      'currentStep': 4,
      'currentVotingTurnIndex': 0,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> saveVoteSelection({
    required String gameId,
    required String colorName,
  }) async {
    final game = await continueGame(gameId);
    final players = List<GamePlayer>.from(game.players);
    final currentIndex = game.currentVotingTurnIndex;
    final selectedPlayer = players.firstWhere(
      (GamePlayer player) => player.selectedColor == colorName,
    );

    players[currentIndex] = players[currentIndex].copyWith(
      voteAnswer: selectedPlayer.answer,
    );

    final isLastTurn = currentIndex >= players.length - 1;
    await _games.doc(gameId).update(<String, dynamic>{
      'players': players.map((player) => player.toMap()).toList(),
      'stage': isLastTurn ? 'completed' : 'voting',
      'currentVotingTurnIndex': isLastTurn ? currentIndex : currentIndex + 1,
      'updatedAt': Timestamp.now(),
    });

    if (isLastTurn) {
      final gameWithVotes = game.copyWith(players: players);
      final results = calculateResults(gameWithVotes);
      await finishGame(gameId, results);
    }
  }

  Map<String, int> calculateResults(GameDocument game) {
    final results = <String, int>{};
    for (final player in game.players) {
      if (player.answer.isNotEmpty) {
        results.putIfAbsent(player.answer, () => 0);
      }
      if (player.voteAnswer.isNotEmpty) {
        results[player.voteAnswer] = (results[player.voteAnswer] ?? 0) + 1;
      }
    }
    return results;
  }

  Future<void> finishGame(String gameId, Map<String, int> results) async {
    final now = Timestamp.now();
    final maxVotes = results.values.isEmpty
        ? 0
        : results.values.reduce((int a, int b) => a > b ? a : b);
    final winners = results.entries
        .where((entry) => entry.value == maxVotes && maxVotes > 0)
        .map((entry) => entry.key)
        .toList();
    final isTie = winners.length > 1;

    await _games.doc(gameId).update(<String, dynamic>{
      'results': results,
      'winnerAnswer': isTie || winners.isEmpty ? '' : winners.first,
      'isTie': isTie,
      'status': 'completed',
      'stage': 'completed',
      'currentStep': 5,
      'finishedAt': now,
      'updatedAt': now,
    });
  }

  Stream<List<GameDocument>> getInProgressGames() {
    return _games.snapshots().map((snapshot) {
      final games = _mapQuerySnapshot(
        snapshot,
      ).where((game) => game.status == 'in_progress').toList();
      games.sort((a, b) {
        final aTime = a.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      });
      return games;
    });
  }

  Stream<List<GameDocument>> getCompletedGames() {
    return _games.snapshots().map((snapshot) {
      final games = _mapQuerySnapshot(
        snapshot,
      ).where((game) => game.status == 'completed').toList();
      games.sort((a, b) {
        final aTime = a.finishedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.finishedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      });
      return games;
    });
  }

  Future<GameDocument> continueGame(String gameId) async {
    final doc = await _games.doc(gameId).get();
    return GameDocument.fromSnapshot(doc);
  }

  Future<GameDocument> restartPlayerAnswers(String gameId) async {
    final game = await continueGame(gameId);
    final resetPlayers = game.players
        .map(
          (player) =>
              player.copyWith(answer: '', selectedColor: '', voteAnswer: ''),
        )
        .toList();

    await _games.doc(gameId).update(<String, dynamic>{
      'players': resetPlayers.map((player) => player.toMap()).toList(),
      'stage': 'players_answers',
      'currentStep': 2,
      'currentPlayerIndex': 0,
      'updatedAt': Timestamp.now(),
    });

    return game.copyWith(
      players: resetPlayers,
      stage: 'players_answers',
      currentStep: 2,
      currentPlayerIndex: 0,
    );
  }

  Future<String> repeatGame(GameDocument sourceGame) async {
    final now = Timestamp.now();
    final players = _assignColors(
      sourceGame.players
          .map((player) => player.copyWith(voteAnswer: '', selectedColor: ''))
          .toList(),
    );

    final doc = await _games.add(<String, dynamic>{
      'activityName': sourceGame.activityName,
      'playersCount': sourceGame.playersCount,
      'createdBy': sourceGame.createdBy,
      'status': 'in_progress',
      'stage': 'voting',
      'currentStep': 4,
      'currentPlayerIndex': 0,
      'currentVotingTurnIndex': 0,
      'winnerAnswer': '',
      'isTie': false,
      'results': <String, int>{},
      'players': players.map((player) => player.toMap()).toList(),
      'createdAt': now,
      'updatedAt': now,
      'finishedAt': null,
    });

    return doc.id;
  }

  Stream<GameDocument> watchGame(String gameId) {
    return _games.doc(gameId).snapshots().map(GameDocument.fromSnapshot);
  }

  List<GameDocument> _mapQuerySnapshot(
    QuerySnapshot<Map<String, dynamic>> snapshot,
  ) {
    return snapshot.docs.map(GameDocument.fromSnapshot).toList();
  }

  List<GamePlayer> _assignColors(List<GamePlayer> source) {
    final existingColors = source
        .where((player) => player.selectedColor.isNotEmpty)
        .toList();
    if (existingColors.length == source.length) {
      return source;
    }

    final availableColors = <String>[
      'blue',
      'green',
      'purple',
      'orange',
      'pink',
      'cyan',
      'yellow',
      'red',
      'teal',
      'indigo',
    ]..shuffle(_random);
    return List<GamePlayer>.generate(source.length, (int index) {
      return source[index].copyWith(selectedColor: availableColors[index]);
    });
  }
}
