import 'game_player.dart';

class GameDocument {
  const GameDocument({
    required this.id,
    required this.activityName,
    required this.playersCount,
    required this.createdBy,
    required this.status,
    required this.stage,
    required this.currentStep,
    required this.currentPlayerIndex,
    required this.currentVotingTurnIndex,
    required this.winnerAnswer,
    required this.isTie,
    required this.results,
    required this.players,
    required this.createdAt,
    required this.updatedAt,
    required this.finishedAt,
  });

  final String id;
  final String activityName;
  final int playersCount;
  final String createdBy;
  final String status;
  final String stage;
  final int currentStep;
  final int currentPlayerIndex;
  final int currentVotingTurnIndex;
  final String winnerAnswer;
  final bool isTie;
  final Map<String, int> results;
  final List<GamePlayer> players;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? finishedAt;

  bool get isCompleted => status == 'completed';

  GamePlayer? get winnerPlayer {
    if (winnerAnswer.isEmpty) {
      return null;
    }

    for (final player in players) {
      if (player.id == winnerAnswer) {
        return player;
      }
    }

    for (final player in players) {
      if (player.answer == winnerAnswer) {
        return player;
      }
    }

    return null;
  }

  String get winnerChoice {
    final player = winnerPlayer;
    if (player != null) {
      return player.answer;
    }
    return winnerAnswer;
  }

  String get winnerPlayerName {
    return winnerPlayer?.name ?? '';
  }

  int voteCountForPlayer(GamePlayer player) {
    final byId = results[player.id];
    if (byId != null) {
      return byId;
    }
    return results[player.answer] ?? 0;
  }

  GameDocument copyWith({
    String? id,
    String? activityName,
    int? playersCount,
    String? createdBy,
    String? status,
    String? stage,
    int? currentStep,
    int? currentPlayerIndex,
    int? currentVotingTurnIndex,
    String? winnerAnswer,
    bool? isTie,
    Map<String, int>? results,
    List<GamePlayer>? players,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? finishedAt,
  }) {
    return GameDocument(
      id: id ?? this.id,
      activityName: activityName ?? this.activityName,
      playersCount: playersCount ?? this.playersCount,
      createdBy: createdBy ?? this.createdBy,
      status: status ?? this.status,
      stage: stage ?? this.stage,
      currentStep: currentStep ?? this.currentStep,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
      currentVotingTurnIndex:
          currentVotingTurnIndex ?? this.currentVotingTurnIndex,
      winnerAnswer: winnerAnswer ?? this.winnerAnswer,
      isTie: isTie ?? this.isTie,
      results: results ?? this.results,
      players: players ?? this.players,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      finishedAt: finishedAt ?? this.finishedAt,
    );
  }
}
