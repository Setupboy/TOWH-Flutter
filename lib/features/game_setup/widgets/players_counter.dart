import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class PlayersCounter extends StatelessWidget {
  static const int minPlayers = 3;
  static const int maxPlayers = 20;

  final int players;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const PlayersCounter({
    super.key,
    required this.players,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 89,
      decoration: BoxDecoration(
        color: kColorWhite50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kColorYellow100, width: 1),
      ),
      child: Row(children: [_removeButton(), _counter(), _addButton()]),
    );
  }

  Widget _removeButton() {
    final bool isEnabled = players > minPlayers;

    return SizedBox(
      width: 72,
      height: double.infinity,
      child: Material(
        color: isEnabled ? kColorYellow200 : kColorYellow100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
          onTap: isEnabled ? onRemove : null,
          child: Center(
            child: Icon(
              Icons.remove,
              size: 25,
              color: isEnabled ? kColorBlue800 : kColorBlue100,
            ),
          ),
        ),
      ),
    );
  }

  Widget _counter() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$players',
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w500,
              fontFamily: kFontMPL,
              color: kColorGreen400,
              height: 1.0,
            ),
          ),
          const Text(
            'Players',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: kFontMPL,
              color: kColorGreen400,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _addButton() {
    final bool isEnabled = players < maxPlayers;

    return SizedBox(
      width: 72,
      height: double.infinity,
      child: Material(
        color: isEnabled ? kColorYellow200 : kColorYellow100,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          onTap: isEnabled ? onAdd : null,
          child: Center(
            child: Icon(
              Icons.add,
              size: 25,
              color: isEnabled ? kColorBlue800 : kColorBlue100,
            ),
          ),
        ),
      ),
    );
  }
}
