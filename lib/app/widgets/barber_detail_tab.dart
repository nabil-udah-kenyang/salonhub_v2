import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class BarberDetailTab extends StatelessWidget {
  const BarberDetailTab({
    super.key,
    required this.label,
    required this.icon,
    this.selected = false,
    this.onTap,
  });

  static const _iconPath = 'lib/assets/icons/';

  final String label;
  final String icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary900 : AppColors.primary500;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 31,
        decoration: selected
            ? BoxDecoration(
                border: Border.all(color: AppColors.primary900),
                borderRadius: BorderRadius.circular(6),
              )
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              '$_iconPath$icon',
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(width: 5),
            Text(label, style: AppTextStyles.caption1.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
