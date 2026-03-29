import 'package:flutter/material.dart';

import '../../../core/models/game_document.dart';
import '../../../core/repositories/game_repository.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/player_data.dart';
import '../../../core/widgets/game_fullscreen_scope.dart';
import '../../home/screens/home_view.dart';
import '../widgets/activity_input.dart';
import '../widgets/continue_button.dart';
import '../widgets/game_setup_app_bar.dart';
import '../widgets/players_counter.dart';
import '../widgets/quick_guide.dart';
import 'ready_to_play_view.dart';

class NewGameView extends StatefulWidget {
  const NewGameView({
    super.key,
    this.gameId,
    this.initialStep,
    this.initialGame,
  });

  final String? gameId;
  final int? initialStep;
  final GameDocument? initialGame;

  @override
  State<NewGameView> createState() => _NewGameViewState();
}

class _NewGameViewState extends State<NewGameView> {
  static const Duration _stepZeroBottomAnimationDuration = Duration(
    milliseconds: 320,
  );
  static const double _swipeVelocityThreshold = 300;

  final GameRepository _repository = GameRepository.instance;

  int players = 3;
  int _stepIndex = 0;
  int _currentPlayerIndex = 0;
  bool _autoAssignEnabled = false;
  bool _showStepZeroBottom = false;
  bool _isStepZeroExitAnimating = false;
  bool _isLoading = false;
  String? _activityErrorText;
  String? _noteErrorText;
  String? _gameId;
  final List<String?> _playerNameErrors = [];
  final List<String> _playerChoices = [];

  final TextEditingController _activityController = TextEditingController();
  final FocusNode _activityFocusNode = FocusNode();
  final TextEditingController _noteController = TextEditingController();
  final FocusNode _noteFocusNode = FocusNode();
  final List<TextEditingController> _playerControllers = [];
  final List<FocusNode> _playerFocusNodes = [];

  @override
  void initState() {
    super.initState();
    _activityFocusNode.addListener(_onTextFieldFocusChanged);
    _noteFocusNode.addListener(_onTextFieldFocusChanged);
    _syncPlayerControllers();
    _stepIndex = widget.initialStep ?? 0;
    if (_stepIndex == 0) {
      _startStepZeroBottomEntrance();
    } else {
      _showStepZeroBottom = false;
    }
    if (widget.initialGame != null) {
      _applyGameState(widget.initialGame!);
    } else {
      _loadExistingGame();
    }
  }

  @override
  void dispose() {
    _activityController.dispose();
    _activityFocusNode
      ..removeListener(_onTextFieldFocusChanged)
      ..dispose();
    _noteController.dispose();
    _noteFocusNode
      ..removeListener(_onTextFieldFocusChanged)
      ..dispose();
    for (final controller in _playerControllers) {
      controller.dispose();
    }
    for (final focusNode in _playerFocusNodes) {
      focusNode
        ..removeListener(_onTextFieldFocusChanged)
        ..dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hideBottomWidgets = _isKeyboardVisible(context);

    return GameFullscreenScope(
      child: Scaffold(
        backgroundColor: kColorWhite50,
        appBar: gameSetupAppBar(
          context,
          onBack: _stepIndex > 0 ? _previousStep : _goBackToHome,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          child: SafeArea(
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
                                FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
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
                  if (_stepIndex == 0 && !hideBottomWidgets) ...[
                    _buildStepZeroAnimatedBottom(child: const QuickGuide()),
                  ],
                  if (_stepIndex == 2 && !hideBottomWidgets) ...[
                    const SizedBox(height: 12),
                    _buildSecretWarning(),
                  ],
                  if (!hideBottomWidgets) ...[
                    SizedBox(height: _stepIndex == 0 ? 8 : 24),
                    _buildBottomActions(),
                  ],
                ],
              ),
            ),
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
                focusNode: _activityFocusNode,
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
                    height: 1,
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
                        if (value) {
                          FocusScope.of(context).unfocus();
                          for (int i = 0; i < _playerNameErrors.length; i++) {
                            _playerNameErrors[i] = null;
                          }
                        } else {
                          for (final controller in _playerControllers) {
                            controller.clear();
                          }
                          for (int i = 0; i < _playerNameErrors.length; i++) {
                            _playerNameErrors[i] = null;
                          }
                        }
                      });
                      if (value) _autoAssignPlayers();
                    },
                    activeThumbColor: Colors.white,
                    activeTrackColor: kColorGreen50,
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
            children: List.generate(players, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: index == players - 1 ? 0 : 16),
                child: _labeledInput(
                  label: 'Player ${index + 1}',
                  hintText: 'Player Name',
                  controller: _playerControllers[index],
                  focusNode: _playerFocusNodes[index],
                  readOnly: _autoAssignEnabled,
                  errorText: _playerNameErrors[index],
                  onChanged: (value) {
                    if (_playerNameErrors[index] != null &&
                        value.trim().isNotEmpty) {
                      setState(() => _playerNameErrors[index] = null);
                    }
                  },
                ),
              );
            }),
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
                      backgroundColor: avatarColorFromName(_currentPlayerName),
                      child: Text(
                        initialsFromName(_currentPlayerName),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: kColorWhite100,
                          fontFamily: kFontMPL,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _currentPlayerName,
                      style: const TextStyle(
                        fontSize: 42,
                        fontFamily: kFontMPL,
                        fontWeight: FontWeight.w800,
                        color: kColorBlue900,
                        height: 1,
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
                  focusNode: _noteFocusNode,
                  errorText: _noteErrorText,
                  onChanged: (value) {
                    if (_noteErrorText != null && value.trim().isNotEmpty) {
                      setState(() => _noteErrorText = null);
                    }
                  },
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
    FocusNode? focusNode,
    bool readOnly = false,
    String? errorText,
    ValueChanged<String>? onChanged,
  }) {
    final hasError = errorText != null && errorText.isNotEmpty;
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
            focusNode: focusNode,
            readOnly: readOnly,
            onChanged: onChanged,
            enableSuggestions: false,
            keyboardType: TextInputType.text,
            cursorColor: kColorBlue800,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(
              fontFamily: kFontMPL,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kColorBlue900,
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
                borderSide: BorderSide(
                  color: hasError ? kColorRed600 : kColorGray50,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: hasError ? kColorRed600 : kColorGray50,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(
            errorText,
            style: const TextStyle(
              fontFamily: kFontMPL,
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: kColorRed600,
            ),
          ),
        ],
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

    final button = ContinueButton(
      label: labelName,
      onPressed: _isLoading ? () {} : () => _nextStep(),
    );

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

  bool _isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  String get _currentPlayerName {
    if (_currentPlayerIndex < _playerControllers.length) {
      final name = _playerControllers[_currentPlayerIndex].text.trim();
      if (name.isNotEmpty) return name;
    }
    return 'Player ${_currentPlayerIndex + 1}';
  }

  void _onTextFieldFocusChanged() {
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _nextStep() async {
    if (_stepIndex == 0) {
      final activityName = _activityController.text.trim();
      if (activityName.isEmpty) {
        setState(() => _activityErrorText = 'Activity name is required');
        return;
      }
      if (_isStepZeroExitAnimating) return;
      setState(() {
        _isLoading = true;
        _isStepZeroExitAnimating = true;
        _activityErrorText = null;
        _showStepZeroBottom = false;
      });
      _gameId ??= await _repository.createGame(
        activityName: activityName,
        playersCount: players,
      );
      await Future.delayed(_stepZeroBottomAnimationDuration);
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _isStepZeroExitAnimating = false;
        if (_autoAssignEnabled) {
          for (int i = 0; i < _playerControllers.length; i++) {
            _playerControllers[i].text = 'Player ${i + 1}';
          }
        }
        _stepIndex = 1;
      });
      return;
    }

    if (_stepIndex == 1) {
      if (!_autoAssignEnabled) {
        bool hasAnyError = false;
        for (int i = 0; i < _playerControllers.length; i++) {
          final isEmpty = _playerControllers[i].text.trim().isEmpty;
          _playerNameErrors[i] = isEmpty
              ? 'Write player name or active auto assign'
              : null;
          if (isEmpty) hasAnyError = true;
        }
        if (hasAnyError) {
          setState(() {});
          return;
        }
      }

      setState(() => _isLoading = true);
      await _repository.savePlayerNames(
        _gameId!,
        _playerControllers.map((controller) {
          final name = controller.text.trim();
          return name.isEmpty ? 'Player' : name;
        }).toList(),
      );
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _currentPlayerIndex = 0;
        _stepIndex = 2;
      });
      return;
    }

    final note = _noteController.text.trim();
    if (note.isEmpty) {
      setState(() => _noteErrorText = 'Player choice is required');
      return;
    }

    _playerChoices[_currentPlayerIndex] = note;
    setState(() => _isLoading = true);
    await _repository.savePlayerAnswer(
      gameId: _gameId!,
      playerIndex: _currentPlayerIndex,
      answer: note,
    );

    if (!mounted) return;

    if (_currentPlayerIndex < players - 1) {
      setState(() {
        _isLoading = false;
        _currentPlayerIndex++;
        _noteController.clear();
        _noteErrorText = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ReadyToPlayView(gameId: _gameId!)),
      );
    }
  }

  void _previousStep() {
    if (_stepIndex == 1) {
      setState(() => _stepIndex = 0);
      _startStepZeroBottomEntrance();
      return;
    }
    if (_stepIndex == 2 && _currentPlayerIndex > 0) {
      setState(() {
        _currentPlayerIndex--;
        _noteController.clear();
        _noteErrorText = null;
      });
      return;
    }
    if (_stepIndex > 1) {
      setState(() => _stepIndex--);
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity > _swipeVelocityThreshold) {
      if (_stepIndex == 0) {
        _goBackToHome();
        return;
      }
      _previousStep();
      return;
    }
    if (velocity < -_swipeVelocityThreshold) {
      _nextStep();
    }
  }

  void _goBackToHome() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeView(),
        transitionDuration: const Duration(milliseconds: 260),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
          return SlideTransition(position: slide, child: child);
        },
      ),
    );
  }

  void _syncPlayerControllers() {
    while (_playerControllers.length < players) {
      final controller = TextEditingController();
      if (_autoAssignEnabled) {
        controller.text = 'Player ${_playerControllers.length + 1}';
      }
      _playerControllers.add(controller);
      final focusNode = FocusNode()..addListener(_onTextFieldFocusChanged);
      _playerFocusNodes.add(focusNode);
      _playerNameErrors.add(null);
      _playerChoices.add('');
    }
    while (_playerControllers.length > players) {
      _playerControllers.removeLast().dispose();
      _playerFocusNodes.removeLast()
        ..removeListener(_onTextFieldFocusChanged)
        ..dispose();
      _playerNameErrors.removeLast();
      _playerChoices.removeLast();
    }
    if (_autoAssignEnabled) {
      for (int i = 0; i < _playerControllers.length; i++) {
        _playerControllers[i].text = 'Player ${i + 1}';
      }
    }
  }

  void _autoAssignPlayers() {
    setState(() {
      for (int i = 0; i < _playerControllers.length; i++) {
        _playerControllers[i].text = 'Player ${i + 1}';
      }
    });
  }

  Future<void> _loadExistingGame() async {
    if (widget.gameId == null) return;
    final game = await _repository.continueGame(widget.gameId!);
    if (!mounted) return;
    setState(() {
      _applyGameState(game);
    });
  }

  void _applyGameState(GameDocument game) {
    _gameId = game.id;
    _activityController.text = game.activityName;
    players = game.playersCount;
    _syncPlayerControllers();

    for (
      int i = 0;
      i < game.players.length && i < _playerControllers.length;
      i++
    ) {
      _playerControllers[i].text = game.players[i].name;
      _playerChoices[i] = game.players[i].answer;
    }

    _currentPlayerIndex = game.currentPlayerIndex;
    _noteController.text = (_currentPlayerIndex < _playerChoices.length)
        ? _playerChoices[_currentPlayerIndex]
        : '';
    _stepIndex = widget.initialStep ?? _stepIndexFromStage(game.stage);
  }

  int _stepIndexFromStage(String stage) {
    switch (stage) {
      case 'players_names':
        return 1;
      case 'players_answers':
        return 2;
      default:
        return 0;
    }
  }
}
