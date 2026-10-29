import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class OpeningHourRow extends StatelessWidget {
  const OpeningHourRow({super.key, required this.day, required this.hours});

  final String day;
  final String hours;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            day,
            style: AppTextStyles.caption1.copyWith(
              color: AppColors.coolGray500,
            ),
          ),
        ),
        Text(
          hours,
          style: AppTextStyles.caption1.copyWith(
            color: AppColors.blueGray900,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
