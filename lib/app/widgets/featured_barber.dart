import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/models/barber.dart';

import 'explore_info_row.dart';

class FeaturedBarber extends StatelessWidget {
  const FeaturedBarber({super.key, required this.barber, this.onTap});

  final Barber barber;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: AppColors.blueGray100),
                  Image.asset(barber.image, fit: BoxFit.cover),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: const BoxDecoration(
                        color: AppColors.primary900,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Pesan',
                            style: AppTextStyles.caption1.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(
                            'lib/assets/icons/Calendar Mark.svg',
                            width: 14,
                            height: 14,
                            colorFilter: const ColorFilter.mode(
                              AppColors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            barber.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.subHeadline3.copyWith(
              color: AppColors.coolGray900,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          ExploreInfoRow(
            iconAsset: 'lib/assets/icons/Map Point.svg',
            text: '${barber.description} (${barber.distance})',
          ),
          const SizedBox(height: 3),
          ExploreInfoRow(
            iconAsset: 'lib/assets/icons/Star.svg',
            text: barber.rating,
          ),
        ],
      ),
    );
  }
}
