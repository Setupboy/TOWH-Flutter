import 'package:flutter/material.dart';
import 'package:towh/constants/color.dart';
import 'package:towh/constants/font.dart';

class PlayerChip extends StatelessWidget {
  final String name;
  final String imageUrl;

  const PlayerChip({required this.name, required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: kYellowColor200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 13, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 6),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kBlueColor900,
              fontFamily: kMPLFont,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
