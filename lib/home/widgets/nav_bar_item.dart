import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:towh/constants/color.dart';
import 'package:towh/constants/font.dart';

class NavBarItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBarItem({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? kYellowColor200 : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isSelected ? kBlueColor900 : kBlueColor800,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? kBlueColor900 : kBlueColor800,
                fontWeight: FontWeight.w400,
                fontFamily: kMPLFont,
                height: 1.0,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
