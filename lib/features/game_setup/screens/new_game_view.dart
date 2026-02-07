import 'package:flutter/material.dart';

import '../../../core/theme/color.dart';
import '../../../core/theme/font.dart';
import '../../home/screens/home_view.dart';
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
  int _stepIndex = 0;

  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _activityController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWithe50,
      appBar: customAppBar(
        context,
        onBack: _stepIndex > 0
            ? _previousStep
            : () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Homeview()),
                );
              },
      ),
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
                      const SizedBox(height: 12),
                      const SizedBox(height: 24),
                      _buildStepContent(),
                    ],
                  ),
                ),
              ),
              if (_stepIndex == 0) ...[const QuickGuide()],
              const SizedBox(height: 12),
              _buildBottomActions(),
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

  Widget _buildStepContent() {
    switch (_stepIndex) {
      case 0:
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          decoration: BoxDecoration(
            color: kColorWithe100,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ActivityInput(controller: _activityController),
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
        );
      case 1:
        return _buildDetailsStep();
      case 2:
        return _buildFinalStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDetailsStep() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      decoration: BoxDecoration(
        color: kColorWithe100,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _labeledInput(
            label: 'Player 1',
            hintText: 'Player Name',
            controller: _locationController,
          ),
          const SizedBox(height: 16),
          _labeledInput(
            label: 'Player 2',
            hintText: 'Player Name',
            controller: _locationController,
          ),
          const SizedBox(height: 16),
          _labeledInput(
            label: 'Player 3',
            hintText: 'Player Name',
            controller: _locationController,
          ),
        ],
      ),
    );
  }

  Widget _buildFinalStep() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      decoration: BoxDecoration(
        color: kColorWithe100,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _labeledInput(
            label: 'Your Choice',
            hintText: 'Write Answer ',
            controller: _noteController,
          ),
        ],
      ),
    );
  }

  Widget _labeledInput({
    required String label,
    required String hintText,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: kFontMPL,
            color: kColorBlue900,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 37,
          child: TextField(
            controller: controller,
            enableSuggestions: false,
            keyboardType: keyboardType,
            cursorColor: kColorBlue100,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(
              fontFamily: kFontMPL,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kColorBlue800,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontFamily: kFontMPL,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: kColorBlue100,
              ),
              filled: true,
              fillColor: kColorWithe50,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: kColorGray100, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: kColorGray100, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    final bool isLastStep = _stepIndex == 2;

    final String labelName;
    switch (_stepIndex) {
      case 1:
        labelName = 'Confirm Players';
      case 2:
        labelName = 'Confirm and Next player';
      default:
        labelName = 'Continue';
    }

    return ContinueButton(label: labelName, onPressed: _nextStep);
  }

  void _nextStep() {
    if (_stepIndex < 2) {
      setState(() => _stepIndex++);
    } else {
      // Final step action (placeholder)
      Navigator.pop(context);
    }
  }

  void _previousStep() {
    if (_stepIndex > 0) {
      setState(() => _stepIndex--);
    }
  }
}
