import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class AppointmentTimeChip extends StatelessWidget {
  const AppointmentTimeChip({
    super.key,
    required this.time,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final String time;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = enabled ? AppColors.primary900 : AppColors.primary300;

    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 59,
        height: 25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary50 : null,
          border: Border.all(
            color: selected || enabled
                ? AppColors.primary900
                : AppColors.primary200,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          time,
          style: AppTextStyles.caption1.copyWith(color: foreground),
        ),
      ),
    );
  }
}
