import 'package:flutter/material.dart';

import '../../../core/theme/color.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWithe50,
      appBar: AppBar(
        backgroundColor: kColorWithe50,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
