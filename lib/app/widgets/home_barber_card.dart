import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/models/barber.dart';

class HomeBarberCard extends StatelessWidget {
  const HomeBarberCard({
    super.key,
    required this.barber,
    this.compact = false,
    this.showBooking = true,
    this.showBorder = true,
    this.onTap,
  });

  final Barber barber;
  final bool compact;
  final bool showBooking;
  final bool showBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  barber.image,
                  width: 160,
                  height: 82,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                barber.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.subHeadline3.copyWith(
                  color: AppColors.coolGray900,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              _BarberMeta(barber: barber),
            ],
          ),
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: showBorder
            ? BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.coolGray200),
              )
            : null,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                barber.image,
                width: 92,
                height: 92,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Text(
                    barber.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption1.copyWith(
                      color: AppColors.coolGray500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _BarberMeta(barber: barber),
                ],
              ),
            ),
            if (showBooking) ...[
              const SizedBox(width: 4),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 30),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  side: const BorderSide(color: AppColors.primary900),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  'Pesan',
                  style: AppTextStyles.caption2.copyWith(
                    color: AppColors.primary900,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BarberMeta extends StatelessWidget {
  const _BarberMeta({required this.barber});

  final Barber barber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on, size: 12, color: AppColors.primary900),
        const SizedBox(width: 2),
        Text(
          barber.distance,
          style: AppTextStyles.caption2.copyWith(color: AppColors.coolGray500),
        ),
        const SizedBox(width: 8),
        SvgPicture.asset('lib/assets/icons/Star.svg', width: 12, height: 12),
        const SizedBox(width: 2),
        Text(
          barber.rating,
          style: AppTextStyles.caption2.copyWith(color: AppColors.coolGray500),
        ),
      ],
    );
  }
}
