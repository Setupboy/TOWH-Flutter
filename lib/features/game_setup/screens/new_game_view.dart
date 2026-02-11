import 'package:flutter/material.dart';

import '../../../core/theme/color.dart';
import '../../../core/theme/font.dart';
import '../../../core/utils/player_data.dart';
import '../../home/screens/home_view.dart';
import '../widgets/activity_input.dart';
import '../widgets/continue_button.dart';
import '../widgets/players_counter.dart';
import '../widgets/quick_guide.dart';
import 'custom_app_bar.dart';
import 'ready_to_play_view.dart';

class NewGameView extends StatefulWidget {
  const NewGameView({super.key});

  @override
  State<NewGameView> createState() => _NewGameViewState();
}

class _NewGameViewState extends State<NewGameView> {
  int players = 3;
  int _stepIndex = 0;
  int _currentPlayerIndex = 0;
  bool _autoAssignEnabled = false;

  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final List<TextEditingController> _playerControllers = [];

  @override
  void initState() {
    super.initState();
    _syncPlayerControllers();
  }

  @override
  void dispose() {
    _activityController.dispose();
    _noteController.dispose();
    for (final controller in _playerControllers) {
      controller.dispose();
    }
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
                      if (_stepIndex != 2) ...[
                        _introText(),
                        const SizedBox(height: 12),
                        const SizedBox(height: 24),
                      ],
                      _buildStepContent(),
                    ],
                  ),
                ),
              ),
              if (_stepIndex == 0) ...[const QuickGuide()],
              if (_stepIndex == 2) ...[
                const SizedBox(height: 12),
                _buildSecretWarning(),
              ],
              const SizedBox(height: 24),
              _buildBottomActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _introText() {
    if (_stepIndex == 2) {
      return const SizedBox.shrink();
    }
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
                onAdd: () => setState(() {
                  players++;
                  _syncPlayerControllers();
                }),
                onRemove: () => setState(() {
                  if (players > 3) players--;
                  _syncPlayerControllers();
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
    return Column(
      children: [
        SizedBox(
          height: 38,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Players Names',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    fontFamily: kFontBaloo2,
                    color: kColorBlue900,
                    height: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Auto assign',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: kFontMPL,
                  color: kColorBlue800,
                  height: 1.86,
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                width: 28,
                height: 16,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch.adaptive(
                    value: _autoAssignEnabled,
                    onChanged: (value) {
                      setState(() {
                        _autoAssignEnabled = value;
                      });
                      if (value) _autoAssignPlayers();
                    },

                    activeThumbColor: Colors.white,
                    activeTrackColor: kColorGreen100,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: kColorGray100,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          decoration: BoxDecoration(
            color: kColorWithe100,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: List.generate(players, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == players - 1 ? 0 : 16,
                    ),
                    child: _labeledInput(
                      label: 'Player ${index + 1}',
                      hintText: 'Player Name',
                      controller: _playerControllers[index],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFinalStep() {
    final activityName = _activityController.text.trim().isEmpty
        ? 'Restaurant Night'
        : _activityController.text.trim();

    return SizedBox(
      width: 380,
      height: 370,
      child: Column(
        children: [
          const SizedBox(height: 1),
          SizedBox(
            width: 380,
            height: 118,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Its time for choose:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: kFontMPL,
                    fontWeight: FontWeight.w400,
                    color: kColorBlue800,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(_currentPlayer.imageUrl),
                      backgroundColor: kColorWithe100,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _currentPlayer.name,
                      style: const TextStyle(
                        fontSize: 42,
                        fontFamily: kFontMPL,
                        fontWeight: FontWeight.w800,
                        color: kColorBlue900,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Choose your desired answer',
            style: TextStyle(
              fontSize: 16,
              fontFamily: kFontMPL,
              fontWeight: FontWeight.w400,
              color: kColorBlue800,
              height: 1.86,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            decoration: BoxDecoration(
              color: kColorWithe100,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      '🚀  Activity:',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: kFontMPL,
                        fontWeight: FontWeight.w400,
                        color: kColorBlue800,
                        height: 1.86,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      activityName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: kFontMPL,
                        fontWeight: FontWeight.w500,
                        color: kColorBlue900,
                        height: 1.86,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _labeledInput(
                  label: 'Your Choice',
                  hintText: 'Write Answer',
                  controller: _noteController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecretWarning() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      decoration: BoxDecoration(
        color: kColorPink50,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '🤫  Do not share your '),
                TextSpan(
                  text: 'Answer',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
              style: TextStyle(
                fontSize: 16,
                fontFamily: kFontMPL,
                fontWeight: FontWeight.w400,
                color: kColorRed600,
                height: 1.86,
              ),
            ),
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
                borderSide: const BorderSide(color: kColorGray50, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: kColorGray50, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
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
      if (_currentPlayerIndex < players - 1) {
        setState(() {
          _currentPlayerIndex++;
          _noteController.clear();
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const ReadyToPlayView(),
          ),
        );
      }
    }
  }

  void _previousStep() {
    if (_stepIndex > 0) {
      setState(() => _stepIndex--);
    }
  }

  PlayerData get _currentPlayer {
    if (kDemoPlayers.isEmpty) {
      return const PlayerData(name: 'Player', imageUrl: '');
    }
    return kDemoPlayers[_currentPlayerIndex % kDemoPlayers.length];
  }

  void _syncPlayerControllers() {
    while (_playerControllers.length < players) {
      _playerControllers.add(TextEditingController());
    }
    while (_playerControllers.length > players) {
      _playerControllers.removeLast().dispose();
    }
  }

  void _autoAssignPlayers() {
    setState(() {
      for (int i = 0; i < _playerControllers.length; i++) {
        _playerControllers[i].text = 'Player ${i + 1}';
      }
    });
  }
}
