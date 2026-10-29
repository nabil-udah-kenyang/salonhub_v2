import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class FindBarberMarker extends StatelessWidget {
  const FindBarberMarker({super.key, required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: active ? 42 : 38,
      height: active ? 42 : 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? AppColors.primary900 : AppColors.secondary900,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueGray900.withValues(alpha: .2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SvgPicture.asset(
        'lib/assets/icons/Shop.svg',
        width: 25,
        height: 25,
      ),
    );
  }
}
