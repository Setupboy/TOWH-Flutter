import 'package:cloud_firestore/cloud_firestore.dart';

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

  String get winnerPlayerName {
    if (winnerAnswer.isEmpty) {
      return '';
    }
    for (final player in players) {
      if (player.answer == winnerAnswer) {
        return player.name;
      }
    }
    return '';
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

  static GameDocument fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    final playersData = (data['players'] as List<dynamic>? ?? <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(GamePlayer.fromMap)
        .toList();
    final resultsData = Map<String, dynamic>.from(
      data['results'] as Map<String, dynamic>? ?? <String, dynamic>{},
    );

    return GameDocument(
      id: doc.id,
      activityName: data['activityName'] as String? ?? '',
      playersCount: data['playersCount'] as int? ?? 0,
      createdBy: data['createdBy'] as String? ?? '',
      status: data['status'] as String? ?? 'in_progress',
      stage: data['stage'] as String? ?? 'players_names',
      currentStep: data['currentStep'] as int? ?? 1,
      currentPlayerIndex: data['currentPlayerIndex'] as int? ?? 0,
      currentVotingTurnIndex: data['currentVotingTurnIndex'] as int? ?? 0,
      winnerAnswer: data['winnerAnswer'] as String? ?? '',
      isTie: data['isTie'] as bool? ?? false,
      results: resultsData.map(
        (key, value) => MapEntry(key, (value as num?)?.toInt() ?? 0),
      ),
      players: playersData,
      createdAt: _timestampToDateTime(data['createdAt']),
      updatedAt: _timestampToDateTime(data['updatedAt']),
      finishedAt: _timestampToDateTime(data['finishedAt']),
    );
  }

  static DateTime? _timestampToDateTime(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    }
    return null;
  }
}
