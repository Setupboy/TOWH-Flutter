import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/game_session.dart';
import '../../../core/utils/player_data.dart';
import '../../home/screens/home_view.dart';
import '../widgets/activity_input.dart';
import '../widgets/continue_button.dart';
import '../widgets/players_counter.dart';
import '../widgets/quick_guide.dart';
import '../widgets/game_setup_app_bar.dart';
import 'ready_to_play_view.dart';

class NewGameView extends StatefulWidget {
  const NewGameView({super.key});

  @override
  State<NewGameView> createState() => _NewGameViewState();
}

class _NewGameViewState extends State<NewGameView> {
  static const Duration _stepZeroBottomAnimationDuration = Duration(
    milliseconds: 320,
  );

  int players = 3;
  int _stepIndex = 0;
  int _currentPlayerIndex = 0;
  bool _autoAssignEnabled = false;
  bool _showStepZeroBottom = false;
  bool _isStepZeroExitAnimating = false;
  String? _activityErrorText;

  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final List<TextEditingController> _playerControllers = [];

  @override
  void initState() {
    super.initState();
    _syncPlayerControllers();
    _startStepZeroBottomEntrance();
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
      backgroundColor: kColorWhite50,
      appBar: gameSetupAppBar(
        context,
        onBack: _stepIndex > 0
            ? _previousStep
            : () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeView()),
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
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        transitionBuilder: (child, animation) =>
                            FadeTransition(opacity: animation, child: child),
                        layoutBuilder: (currentChild, previousChildren) {
                          return Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              ...previousChildren,
                              if (currentChild != null) currentChild,
                            ],
                          );
                        },
                        child: KeyedSubtree(
                          key: ValueKey<int>(_stepIndex),
                          child: _buildStepContent(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_stepIndex == 0) ...[
                _buildStepZeroAnimatedBottom(child: const QuickGuide()),
              ],
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
            color: kColorWhite100,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ActivityInput(
                controller: _activityController,
                errorText: _activityErrorText,
                onChanged: (value) {
                  if (_activityErrorText != null && value.trim().isNotEmpty) {
                    setState(() => _activityErrorText = null);
                  }
                },
              ),
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
            color: kColorWhite100,
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
    final activityName = _activityController.text.trim();

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
                      backgroundColor: kColorWhite100,
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
              color: kColorWhite100,
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
          width: 348,
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
              fillColor: kColorWhite50,
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

    final button = ContinueButton(label: labelName, onPressed: _nextStep);

    if (_stepIndex == 0) {
      return _buildStepZeroAnimatedBottom(child: button);
    }

    return button;
  }

  Widget _buildStepZeroAnimatedBottom({required Widget child}) {
    return AnimatedSlide(
      duration: _stepZeroBottomAnimationDuration,
      curve: Curves.easeInOut,
      offset: _showStepZeroBottom ? Offset.zero : const Offset(0, 0.28),
      child: AnimatedOpacity(
        duration: _stepZeroBottomAnimationDuration,
        curve: Curves.easeInOut,
        opacity: _showStepZeroBottom ? 1 : 0,
        child: child,
      ),
    );
  }

  void _startStepZeroBottomEntrance() {
    _showStepZeroBottom = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _stepIndex != 0) return;
      setState(() => _showStepZeroBottom = true);
    });
  }

  Future<void> _nextStep() async {
    if (_stepIndex == 0) {
      final activityName = _activityController.text.trim();
      if (activityName.isEmpty) {
        setState(() => _activityErrorText = 'Activity name is required');
        return;
      }
      GameSession.inProgressActivityName = activityName;
      if (_isStepZeroExitAnimating) return;
      setState(() {
        _isStepZeroExitAnimating = true;
        _activityErrorText = null;
        _showStepZeroBottom = false;
      });
      await Future.delayed(_stepZeroBottomAnimationDuration);
      if (!mounted) return;
      setState(() {
        _isStepZeroExitAnimating = false;
        _stepIndex = 1;
      });
      return;
    }

    if (_stepIndex == 1) {
      setState(() => _stepIndex = 2);
      return;
    }

    if (_currentPlayerIndex < players - 1) {
      setState(() {
        _currentPlayerIndex++;
        _noteController.clear();
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ReadyToPlayView(playersCount: players),
        ),
      );
    }
  }

  void _previousStep() {
    if (_stepIndex == 1) {
      setState(() => _stepIndex = 0);
      _startStepZeroBottomEntrance();
      return;
    }
    if (_stepIndex > 1) {
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
