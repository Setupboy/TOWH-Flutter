import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/theme/color.dart';
import '../../../core/theme/font.dart';
import '../../../core/utils/player_data.dart';
import '../../game_setup/screens/ready_to_play_view.dart';
import 'result_view.dart';

class GameView extends StatefulWidget {
  final int playersCount;

  const GameView({super.key, required this.playersCount});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  int _currentPlayerIndex = 0;
  final Random _random = Random();
  late final List<_ChoiceColor> _choiceColors;
  int? _selectedColorIndex;

  @override
  void initState() {
    super.initState();
    _choiceColors = _buildRandomChoices(widget.playersCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWithe50,
      appBar: AppBar(
        foregroundColor: kColorBlue900,
        surfaceTintColor: Colors.transparent,
        backgroundColor: kColorWithe50,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ReadyToPlayView(playersCount: widget.playersCount),
                  ),
                  (route) => false,
                );
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: kColorBlue800,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Play',
              style: TextStyle(
                fontSize: 24,
                fontFamily: kFontBaloo2,
                fontWeight: FontWeight.w600,
                color: kColorBlue900,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              _currentPlayer.imageUrl,
                            ),
                            backgroundColor: kColorWithe100,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _currentPlayer.name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontFamily: kFontMPL,
                              fontWeight: FontWeight.w800,
                              color: kColorBlue900,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        textAlign: TextAlign.center,
                        'Your Turn to\nchoose',
                        style: TextStyle(
                          fontSize: 42,
                          fontFamily: kFontBaloo2,
                          fontWeight: FontWeight.w700,
                          color: kColorBlue900,
                          height: 1.14,
                        ),
                      ),
                      const SizedBox(height: 24),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final double itemWidth =
                              (constraints.maxWidth - 12) / 2;
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: List.generate(_choiceColors.length, (
                              index,
                            ) {
                              final choice = _choiceColors[index];
                              final bool isSelected =
                                  _selectedColorIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setState(() => _selectedColorIndex = index);
                                },
                                child: SizedBox(
                                  width: itemWidth,
                                  child: _buildColorCard(choice, isSelected),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: kFontMPL,
                    fontWeight: FontWeight.w400,
                    color: kColorRed600,
                    height: 1.86,
                  ),
                  children: [
                    const TextSpan(text: 'Choose a color '),
                    TextSpan(
                      text: _currentPlayer.name,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _onContinuePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kColorYellow200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: kFontMPL,
                      fontWeight: FontWeight.w500,
                      color: kColorBlue900,
                      height: 1.46,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PlayerData get _currentPlayer {
    if (kDemoPlayers.isEmpty) {
      return const PlayerData(name: 'Player', imageUrl: '');
    }
    return kDemoPlayers[_currentPlayerIndex % kDemoPlayers.length];
  }

  List<_ChoiceColor> _buildRandomChoices(int count) {
    const seedColors = <_ChoiceColor>[
      _ChoiceColor(name: 'Green', color: Color(0xFF70B80C)),
      _ChoiceColor(name: 'Blue', color: Color(0xFF3277D1)),
      _ChoiceColor(name: 'Violet', color: Color(0xFF9500F2)),
      _ChoiceColor(name: 'Orange', color: Color(0xFFF38B25)),
      _ChoiceColor(name: 'Red', color: Color(0xFFE54B4B)),
      _ChoiceColor(name: 'Pink', color: Color(0xFFE45FB4)),
      _ChoiceColor(name: 'Yellow', color: Color(0xFFF1B51C)),
    ];

    final safeCount = count < 1 ? 1 : count;
    final pool = [...seedColors]..shuffle(_random);

    if (safeCount <= pool.length) {
      return pool.take(safeCount).toList();
    }

    final generated = <_ChoiceColor>[...pool];
    for (int i = pool.length; i < safeCount; i++) {
      final color = HSVColor.fromAHSV(
        1,
        _random.nextDouble() * 360,
        0.75,
        0.9,
      ).toColor();
      generated.add(_ChoiceColor(name: 'Color ${i + 1}', color: color));
    }
    return generated;
  }

  void _onContinuePressed() {
    if (_currentPlayerIndex >= widget.playersCount - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultView(
            resultColors: _choiceColors.map((choice) => choice.color).toList(),
          ),
        ),
      );
      return;
    }
    setState(() {
      _currentPlayerIndex++;
      _selectedColorIndex = null;
    });
  }

  Widget _buildColorCard(_ChoiceColor choice, bool isSelected) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 182,
          height: 167,
          decoration: BoxDecoration(
            color: isSelected ? kColorYellow200 : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(2),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: choice.color,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              if (isSelected)
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: kColorWithe100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                          color: kColorYellow200,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          size: 20,
                          color: kColorWithe100,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          bottom: 2,
          child: Container(
            width: 134,
            height: 22,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: kColorWithe100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                choice.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: kFontMPL,
                  fontWeight: FontWeight.w500,
                  color: kColorBlue900,
                  height: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ChoiceColor {
  final String name;
  final Color color;

  const _ChoiceColor({required this.name, required this.color});
}
