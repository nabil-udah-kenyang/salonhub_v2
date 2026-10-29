import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class BarberDetailQuickAction extends StatelessWidget {
  const BarberDetailQuickAction({
    super.key,
    required this.icon,
    required this.label,
  });

  static const _iconPath = 'lib/assets/icons/';

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset('$_iconPath$icon', width: 22, height: 22),
        const SizedBox(height: 5),
        Text(
          label,
          style: AppTextStyles.caption1.copyWith(color: AppColors.primary900),
        ),
      ],
    );
  }
}
