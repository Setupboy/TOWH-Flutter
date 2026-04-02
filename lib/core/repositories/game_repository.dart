import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:isar/isar.dart';

import '../models/game_document.dart';
import '../models/game_player.dart';
import '../storage/isar_game.dart';
import '../storage/local_database.dart';

class GameRepository {
  GameRepository._();

  static final GameRepository instance = GameRepository._();

  static const List<String> _colors = <String>[
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
    'lime',
    'magenta',
    'brown',
    'navy',
    'mint',
    'amber',
    'coral',
    'sky',
    'olive',
    'slate',
  ];

  final Random _random = Random();

  Isar get _isar => LocalDatabase.instance.isar;

  Future<String> createGame({
    required String activityName,
    required int playersCount,
    String? createdBy,
  }) async {
    final now = DateTime.now();
    final isarGame = IsarGame()
      ..gameId = _newGameId()
      ..activityName = activityName
      ..playersCount = playersCount
      ..createdBy = createdBy ?? ''
      ..status = 'in_progress'
      ..stage = 'players_names'
      ..currentStep = 1
      ..currentPlayerIndex = 0
      ..currentVotingTurnIndex = 0
      ..winnerAnswer = ''
      ..isTie = false
      ..resultsJson = '{}'
      ..playersJson = '[]'
      ..createdAt = now
      ..updatedAt = now
      ..finishedAt = null;

    await _isar.writeTxn(() async {
      await _isar.isarGames.put(isarGame);
    });
    return isarGame.gameId;
  }

  Future<void> savePlayerNames(String gameId, List<String> playerNames) async {
    final game = await continueGame(gameId);
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

    await _saveGame(
      game.copyWith(
        players: players,
        stage: 'players_answers',
        currentStep: 2,
        currentPlayerIndex: 0,
        updatedAt: DateTime.now(),
      ),
    );
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

    await _saveGame(
      game.copyWith(
        stage: isLastPlayer ? 'voting' : 'players_answers',
        currentStep: isLastPlayer ? 4 : 2,
        currentPlayerIndex: isLastPlayer ? 0 : playerIndex + 1,
        currentVotingTurnIndex: isLastPlayer ? 0 : game.currentVotingTurnIndex,
        players: isLastPlayer ? _assignColors(players) : players,
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> startVoting(String gameId) async {
    final game = await continueGame(gameId);
    await _saveGame(
      game.copyWith(
        players: _assignColors(game.players),
        stage: 'voting',
        currentStep: 4,
        currentVotingTurnIndex: 0,
        updatedAt: DateTime.now(),
      ),
    );
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
    final updatedGame = game.copyWith(
      players: players,
      stage: isLastTurn ? 'completed' : 'voting',
      currentVotingTurnIndex: isLastTurn ? currentIndex : currentIndex + 1,
      updatedAt: DateTime.now(),
    );
    await _saveGame(updatedGame);

    if (isLastTurn) {
      await finishGame(gameId, calculateResults(updatedGame));
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
    final game = await continueGame(gameId);
    final now = DateTime.now();
    final maxVotes = results.values.isEmpty
        ? 0
        : results.values.reduce((int a, int b) => a > b ? a : b);
    final winners = results.entries
        .where((entry) => entry.value == maxVotes && maxVotes > 0)
        .map((entry) => entry.key)
        .toList();
    final isTie = winners.length > 1;

    await _saveGame(
      game.copyWith(
        results: results,
        winnerAnswer: isTie || winners.isEmpty ? '' : winners.first,
        isTie: isTie,
        status: 'completed',
        stage: 'completed',
        currentStep: 5,
        finishedAt: now,
        updatedAt: now,
      ),
    );
  }

  Stream<List<GameDocument>> getInProgressGames() {
    return _watchAllGames().map((games) {
      final filtered = games
          .where((game) => game.status == 'in_progress')
          .toList();
      filtered.sort((a, b) {
        final aTime = a.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      });
      return filtered;
    });
  }

  Stream<List<GameDocument>> getCompletedGames() {
    return _watchAllGames().map((games) {
      final filtered = games
          .where((game) => game.status == 'completed')
          .toList();
      filtered.sort((a, b) {
        final aTime = a.finishedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.finishedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      });
      return filtered;
    });
  }

  Future<GameDocument> continueGame(String gameId) async {
    final isarGame = await _isar.isarGames
        .filter()
        .gameIdEqualTo(gameId)
        .findFirst();
    if (isarGame == null) {
      throw StateError('Game not found: $gameId');
    }
    final game = _toGameDocument(isarGame);
    if (game.stage != 'ready_to_play') {
      return game;
    }

    await startVoting(gameId);
    final updatedGame = await _isar.isarGames
        .filter()
        .gameIdEqualTo(gameId)
        .findFirst();
    if (updatedGame == null) {
      throw StateError('Game not found after starting voting: $gameId');
    }
    return _toGameDocument(updatedGame);
  }

  Future<GameDocument> restartPlayerAnswers(String gameId) async {
    final game = await continueGame(gameId);
    final resetPlayers = game.players
        .map(
          (player) =>
              player.copyWith(answer: '', selectedColor: '', voteAnswer: ''),
        )
        .toList();

    final updatedGame = game.copyWith(
      players: resetPlayers,
      stage: 'players_answers',
      currentStep: 2,
      currentPlayerIndex: 0,
      updatedAt: DateTime.now(),
    );
    await _saveGame(updatedGame);
    return updatedGame;
  }

  Future<String> repeatGame(GameDocument sourceGame) async {
    final now = DateTime.now();
    final repeatedGame = sourceGame.copyWith(
      id: _newGameId(),
      status: 'in_progress',
      stage: 'voting',
      currentStep: 4,
      currentPlayerIndex: 0,
      currentVotingTurnIndex: 0,
      winnerAnswer: '',
      isTie: false,
      results: <String, int>{},
      players: _assignColors(
        sourceGame.players
            .map((player) => player.copyWith(voteAnswer: '', selectedColor: ''))
            .toList(),
      ),
      createdAt: now,
      updatedAt: now,
      finishedAt: null,
    );
    await _saveGame(repeatedGame);
    return repeatedGame.id;
  }

  Future<void> deleteGame(String gameId) async {
    await _isar.writeTxn(() async {
      await _isar.isarGames.deleteByGameId(gameId);
    });
  }

  Stream<GameDocument> watchGame(String gameId) {
    return _watchAllGames().map(
      (games) => games.firstWhere((game) => game.id == gameId),
    );
  }

  Stream<List<GameDocument>> _watchAllGames() async* {
    yield await _getAllGames();
    await for (final _ in _isar.isarGames.watchLazy()) {
      yield await _getAllGames();
    }
  }

  Future<List<GameDocument>> _getAllGames() async {
    final games = await _isar.isarGames.where().findAll();
    return games.map(_toGameDocument).toList();
  }

  Future<void> _saveGame(GameDocument game) async {
    final existing = await _isar.isarGames
        .filter()
        .gameIdEqualTo(game.id)
        .findFirst();
    final isarGame = existing ?? IsarGame()
      ..gameId = game.id;
    isarGame
      ..activityName = game.activityName
      ..playersCount = game.playersCount
      ..createdBy = game.createdBy
      ..status = game.status
      ..stage = game.stage
      ..currentStep = game.currentStep
      ..currentPlayerIndex = game.currentPlayerIndex
      ..currentVotingTurnIndex = game.currentVotingTurnIndex
      ..winnerAnswer = game.winnerAnswer
      ..isTie = game.isTie
      ..resultsJson = jsonEncode(game.results)
      ..playersJson = jsonEncode(
        game.players.map((player) => player.toMap()).toList(),
      )
      ..createdAt = game.createdAt ?? DateTime.now()
      ..updatedAt = game.updatedAt ?? DateTime.now()
      ..finishedAt = game.finishedAt;

    await _isar.writeTxn(() async {
      await _isar.isarGames.put(isarGame);
    });
  }

  GameDocument _toGameDocument(IsarGame game) {
    final playersData = (jsonDecode(game.playersJson) as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(GamePlayer.fromMap)
        .toList();
    final resultsData = Map<String, dynamic>.from(
      jsonDecode(game.resultsJson) as Map<String, dynamic>,
    );

    return GameDocument(
      id: game.gameId,
      activityName: game.activityName,
      playersCount: game.playersCount,
      createdBy: game.createdBy,
      status: game.status,
      stage: game.stage,
      currentStep: game.currentStep,
      currentPlayerIndex: game.currentPlayerIndex,
      currentVotingTurnIndex: game.currentVotingTurnIndex,
      winnerAnswer: game.winnerAnswer,
      isTie: game.isTie,
      results: resultsData.map(
        (key, value) => MapEntry(key, (value as num?)?.toInt() ?? 0),
      ),
      players: playersData,
      createdAt: game.createdAt,
      updatedAt: game.updatedAt,
      finishedAt: game.finishedAt,
    );
  }

  List<GamePlayer> _assignColors(List<GamePlayer> source) {
    final alreadyAssigned = source.every(
      (player) => player.selectedColor.isNotEmpty,
    );
    if (alreadyAssigned) {
      return source;
    }
    final availableColors = List<String>.from(_colors)..shuffle(_random);
    return List<GamePlayer>.generate(source.length, (int index) {
      return source[index].copyWith(selectedColor: availableColors[index]);
    });
  }

  String _newGameId() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }
}
