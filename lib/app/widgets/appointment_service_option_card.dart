import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class AppointmentServiceOptionCard extends StatelessWidget {
  const AppointmentServiceOptionCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final String description;
  final String price;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 60),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary900 : AppColors.white,
          border: Border.all(
            color: selected ? AppColors.primary900 : AppColors.primary300,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption1.copyWith(
                      color: selected ? AppColors.white : AppColors.blueGray900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption2.copyWith(
                      color: selected
                          ? AppColors.white.withValues(alpha: .78)
                          : AppColors.blueGray500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Text(
              price,
              style: AppTextStyles.caption1.copyWith(
                color: selected ? AppColors.white : AppColors.primary900,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (selected) ...[
              const SizedBox(width: 8),
              SvgPicture.asset(
                'lib/assets/icons/ceklis_putih.svg',
                width: 18,
                height: 14,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
