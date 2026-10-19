import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class PhoneCountryCodePrefix extends StatelessWidget {
  const PhoneCountryCodePrefix({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 12),
        Text(
          '+62',
          style: AppTextStyles.body3.copyWith(color: AppColors.blueGray400),
        ),
        const SizedBox(width: 6),
        const Icon(
          Icons.keyboard_arrow_down,
          size: 18,
          color: AppColors.blueGray400,
        ),
        const SizedBox(width: 10),
        Container(width: 1, height: 48, color: AppColors.blueGray300),
      ],
    );
  }
}
