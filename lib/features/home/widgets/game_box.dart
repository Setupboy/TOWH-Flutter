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

  const GameBox({
    this.title,
    required this.gameTitle,
    required this.detailLabel,
    required this.detailValue,
    this.secondaryDetailLabel,
    this.secondaryDetailValue,
    required this.players,
    this.onTap,
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

    return SizedBox(
      width: 380,
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
            width: 380,
            child: Card(
              color: kColorWhite100,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
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
                          const Icon(Icons.chevron_right, color: kColorBlue800),
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
                              (widget.secondaryDetailValue?.isNotEmpty ?? false)
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
                    ],
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
