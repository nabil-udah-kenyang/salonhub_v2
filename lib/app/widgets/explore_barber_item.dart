import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/models/barber.dart';

import 'explore_info_row.dart';

class ExploreBarberItem extends StatelessWidget {
  const ExploreBarberItem(this.barber, {super.key, this.onTap});

  final Barber barber;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(7),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                barber.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    barber.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption1.copyWith(
                      color: AppColors.coolGray900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  ExploreInfoRow(
                    iconAsset: 'lib/assets/icons/Map Point.svg',
                    text: '${barber.description} (${barber.distance})',
                  ),
                  const SizedBox(height: 2),
                  ExploreInfoRow(
                    iconAsset: 'lib/assets/icons/Star.svg',
                    text: barber.rating,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
