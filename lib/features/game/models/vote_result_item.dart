import 'package:flutter/material.dart';

class VoteResultItem {
  final String choiceTitle;
  final String playerName;
  final Color color;
  final int voteCount;
  final int order;

  const VoteResultItem({
    required this.choiceTitle,
    required this.playerName,
    required this.color,
    required this.voteCount,
    required this.order,
  });
}
