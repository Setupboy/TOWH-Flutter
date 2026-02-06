import 'package:flutter/material.dart';

import '../../../core/theme/color.dart';
import '../../../core/theme/font.dart';
import '../widgets/activity_input.dart';
import '../widgets/continue_button.dart';
import '../widgets/players_counter.dart';
import '../widgets/quick_guide.dart';
import 'custom_app_bar.dart';

class NewGameView extends StatefulWidget {
  const NewGameView({super.key});

  @override
  State<NewGameView> createState() => _NewGameViewState();
}

class _NewGameViewState extends State<NewGameView> {
  int players = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWithe50,
      appBar: customAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      _introText(),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                        decoration: BoxDecoration(
                          color: kColorWithe100,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ActivityInput(),
                            const SizedBox(height: 24),
                            const Text(
                              'Number of Players',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                fontFamily: kFontMPL,
                                color: kColorBlue900,
                              ),
                            ),
                            const SizedBox(height: 12),
                            PlayersCounter(
                              players: players,
                              onAdd: () => setState(() => players++),
                              onRemove: () => setState(() {
                                if (players > 3) players--;
                              }),
                            ),
                            const SizedBox(height: 4),
                            _minPlayersHint(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const QuickGuide(),
              const SizedBox(height: 12),
              const ContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _introText() {
    return Text(
      'Let’s get the polling hit Up and running',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: kColorBlue800,
        fontFamily: kFontMPL,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
      ),
    );
  }

  Widget _minPlayersHint() {
    return const Center(
      child: Text(
        'ⓘ Minimum of 3 is required',
        style: TextStyle(
          fontSize: 12,
          fontFamily: kFontRoboto,
          fontWeight: FontWeight.w400,
          color: kColorBlue100,
          letterSpacing: 0.5,
          height: 2,
        ),
      ),
    );
  }
}
