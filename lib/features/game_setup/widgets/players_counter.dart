import 'package:flutter/material.dart';

import '../../../core/theme/color.dart';
import '../../../core/theme/font.dart';

class PlayersCounter extends StatelessWidget {
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
        color: kColorWithe50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kColorYellow100, width: 1),
      ),
      child: Row(children: [_removeButton(), _counter(), _addButton()]),
    );
  }

  Widget _removeButton() {
    return Container(
      width: 72,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: kColorYellow50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
      ),
      child: IconButton(
        icon: const Icon(Icons.remove, size: 25, color: kColorBlue100),
        onPressed: onRemove,
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
    return Container(
      width: 72,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: kColorYellow200,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: IconButton(
        icon: const Icon(Icons.add, size: 25, color: kColorBlue800),
        onPressed: onAdd,
      ),
    );
  }
}
