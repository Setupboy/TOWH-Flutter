import 'package:flutter/material.dart';
import 'package:towh/core/theme/app_colors.dart';
import 'package:towh/core/theme/app_fonts.dart';

class GameBox extends StatefulWidget {
  final String? title;
  final String gameTitle;
  final String detailLabel;
  final String detailValue;
  final String? secondaryDetailLabel;
  final String? secondaryDetailValue;
  final List<Widget> players;
  final VoidCallback? onTap;
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;

  const GameBox({
    this.title,
    required this.gameTitle,
    required this.detailLabel,
    required this.detailValue,
    this.secondaryDetailLabel,
    this.secondaryDetailValue,
    required this.players,
    this.onTap,
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    super.key,
  });

  static const int _columns = 3;
  static const double _gridSpacing = 8;
  static const double _chipHeight = 40;

  static const int _maxVisiblePlayersCollapsed = 6;

  @override
  State<GameBox> createState() => _GameBoxState();
}

class _GameBoxState extends State<GameBox> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasMorePlayers =
        widget.players.length > GameBox._maxVisiblePlayersCollapsed;
    final hasActions =
        widget.primaryActionLabel != null &&
        widget.onPrimaryAction != null &&
        widget.secondaryActionLabel != null &&
        widget.onSecondaryAction != null;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            Text(
              widget.title!,
              style: const TextStyle(
                fontFamily: kFontMPL,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: kColorBlue800,
              ),
            ),
            const SizedBox(height: 8),
          ],
          SizedBox(
            width: double.infinity,
            child: Card(
              color: kColorWhite100,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onTap,
                  borderRadius: BorderRadius.circular(24),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.gameTitle,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kColorBlue900,
                                fontFamily: kFontMPL,
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              color: kColorBlue800,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildPlayersGrid(),
                        if (hasMorePlayers) ...[
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              setState(() => _isExpanded = !_isExpanded);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              _isExpanded
                                  ? 'Show less'
                                  : 'Show all (${widget.players.length})',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: kColorBlue800,
                                fontFamily: kFontMPL,
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        (widget.secondaryDetailLabel?.isNotEmpty ?? false) &&
                                (widget.secondaryDetailValue?.isNotEmpty ??
                                    false)
                            ? Row(
                                children: [
                                  Expanded(
                                    child: _DetailText(
                                      label: widget.detailLabel,
                                      value: widget.detailValue,
                                    ),
                                  ),
                                  _DetailText(
                                    label: widget.secondaryDetailLabel!,
                                    value: widget.secondaryDetailValue!,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              )
                            : _DetailText(
                                label: widget.detailLabel,
                                value: widget.detailValue,
                              ),
                        if (hasActions) ...[
                          const SizedBox(height: 16),
                          _ActionButtonsRow(
                            primaryActionLabel: widget.primaryActionLabel!,
                            onPrimaryAction: widget.onPrimaryAction!,
                            secondaryActionLabel: widget.secondaryActionLabel!,
                            onSecondaryAction: widget.onSecondaryAction!,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  const _ActionButtonsRow({
    required this.primaryActionLabel,
    required this.onPrimaryAction,
    required this.secondaryActionLabel,
    required this.onSecondaryAction,
  });

  final String primaryActionLabel;
  final VoidCallback onPrimaryAction;
  final String secondaryActionLabel;
  final VoidCallback onSecondaryAction;

  static const double _designDeleteWidth = 69;
  static const double _designContinueWidth = 267;
  static const double _gap = 12;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final buttonWidth = (availableWidth - _gap).clamp(0.0, double.infinity);
        final totalFlex = (_designDeleteWidth + _designContinueWidth).round();

        return Row(
          children: [
            Expanded(
              flex: _designDeleteWidth.round(),
              child: SizedBox(
                width: buttonWidth * (_designDeleteWidth / totalFlex),
                height: 34,
                child: TextButton(
                  onPressed: onSecondaryAction,
                  style: TextButton.styleFrom(
                    backgroundColor: kColorWhite50,
                    foregroundColor: kColorBlue900,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      secondaryActionLabel,
                      style: const TextStyle(
                        fontFamily: kFontMPL,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: kColorBlue900,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: _gap),
            Expanded(
              flex: _designContinueWidth.round(),
              child: SizedBox(
                width: buttonWidth * (_designContinueWidth / totalFlex),
                height: 34,
                child: ElevatedButton(
                  onPressed: onPrimaryAction,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: kColorYellow200,
                    foregroundColor: kColorBlue900,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      primaryActionLabel,
                      style: const TextStyle(
                        fontFamily: kFontMPL,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: kColorBlue900,
                        height: 1.46,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DetailText extends StatelessWidget {
  const _DetailText({
    required this.label,
    required this.value,
    this.textAlign = TextAlign.left,
  });

  final String label;
  final String value;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 12,
              color: kColorBlue800,
              fontFamily: kFontMPL,
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: kColorBlue900,
              fontFamily: kFontMPL,
            ),
          ),
        ],
      ),
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}

extension on _GameBoxState {
  Widget _buildPlayersGrid() {
    final visiblePlayers =
        _isExpanded ||
            widget.players.length <= GameBox._maxVisiblePlayersCollapsed
        ? widget.players
        : widget.players.take(GameBox._maxVisiblePlayersCollapsed).toList();

    final playersCount = visiblePlayers.length;
    final rows = (playersCount / GameBox._columns).ceil();
    final contentHeight =
        rows * GameBox._chipHeight +
        (rows > 1 ? (rows - 1) * GameBox._gridSpacing : 0);

    return SizedBox(
      height: contentHeight,
      child: GridView.builder(
        itemCount: visiblePlayers.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: GameBox._columns,
          crossAxisSpacing: GameBox._gridSpacing,
          mainAxisSpacing: GameBox._gridSpacing,
          mainAxisExtent: GameBox._chipHeight,
        ),
        itemBuilder: (context, index) => visiblePlayers[index],
      ),
    );
  }
}
