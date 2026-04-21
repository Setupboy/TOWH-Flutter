import 'package:isar_community/isar.dart';

part 'isar_game.g.dart';

@collection
class IsarGame {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String gameId;

  late String activityName;
  late int playersCount;
  late String createdBy;
  late String status;
  late String stage;
  late int currentStep;
  late int currentPlayerIndex;
  late int currentVotingTurnIndex;
  late String winnerAnswer;
  late bool isTie;
  late String resultsJson;
  late String playersJson;
  late DateTime createdAt;
  late DateTime updatedAt;
  DateTime? finishedAt;
}
