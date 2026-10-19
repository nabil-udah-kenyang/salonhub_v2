import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class HomePromoCard extends StatelessWidget {
  const HomePromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 208,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.secondary900,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/backgorund_orange.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: -2,
            bottom: -32,
            height: 245,
            child: Image.asset('lib/assets/intro3.png'),
          ),
          Positioned(
            left: 14,
            top: 12,
            child: SizedBox(
              width: 54,
              height: 38,
              child: Image.asset('lib/assets/logo.png', fit: BoxFit.contain),
            ),
          ),
          Positioned(
            left: 14,
            top: 62,
            width: 165,
            child: Text(
              'Tampil lebih\nrapi, percaya diri\nsetiap hari!',
              style: AppTextStyles.headline3.copyWith(
                color: AppColors.white,
                height: 1.25,
              ),
            ),
          ),
          Positioned(
            left: 14,
            bottom: 16,
            child: SizedBox(
              width: 118,
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary900,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Pesan Sekarang',
                  maxLines: 1,
                  style: AppTextStyles.caption2.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
