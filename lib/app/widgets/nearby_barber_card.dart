import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/models/barber.dart';

class NearbyBarberCard extends StatelessWidget {
  const NearbyBarberCard({super.key, required this.barber, this.onTap});

  final Barber barber;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        width: 290,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.blueGray50,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: AppColors.blueGray900.withValues(alpha: .08),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                barber.image,
                width: 76,
                height: 76,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    barber.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.subHeadline3.copyWith(
                      color: AppColors.blueGray900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  FindBarberMetaLine(
                    iconAsset: 'lib/assets/icons/Map Point.svg',
                    text: '${barber.description} (${barber.distance})',
                  ),
                  const SizedBox(height: 5),
                  FindBarberMetaLine(
                    iconAsset: 'lib/assets/icons/Star.svg',
                    text: '${barber.rating}  (24)',
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

class FindBarberMetaLine extends StatelessWidget {
  const FindBarberMetaLine({
    super.key,
    required this.iconAsset,
    required this.text,
  });

  final String iconAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconAsset, width: 14, height: 14),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption1.copyWith(color: AppColors.primary500),
          ),
        ),
      ],
    );
  }
}
