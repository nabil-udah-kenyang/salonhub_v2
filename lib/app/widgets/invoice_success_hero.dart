import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class InvoiceSuccessHero extends StatelessWidget {
  const InvoiceSuccessHero({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 324,
      child: ColoredBox(
        color: AppColors.primary900,
        child: Column(
          children: [
            SizedBox(
              height: 62,
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBack,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 42,
                      minHeight: 40,
                    ),
                    icon: const Icon(Icons.arrow_back, color: AppColors.white),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Invoice',
                    style: AppTextStyles.headline4.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SvgPicture.asset(
              'lib/assets/icons/Verified Check.svg',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 13),
            Text(
              'Booking berhasil',
              style: AppTextStyles.headline4.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                'Cek menu booking untuk melihat informasi janji temu secara lengkap.',
                textAlign: TextAlign.center,
                style: AppTextStyles.caption1.copyWith(
                  color: AppColors.blueGray200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
