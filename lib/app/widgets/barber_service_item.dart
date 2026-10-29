import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class BarberServiceItem extends StatelessWidget {
  const BarberServiceItem({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  final String name;
  final String description;
  final String price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox(
              width: 38,
              height: 38,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.subHeadline3.copyWith(
                    color: AppColors.blueGray900,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  description,
                  style: AppTextStyles.caption1.copyWith(
                    color: AppColors.coolGray500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            price,
            style: AppTextStyles.body3.copyWith(
              color: AppColors.blueGray900,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
