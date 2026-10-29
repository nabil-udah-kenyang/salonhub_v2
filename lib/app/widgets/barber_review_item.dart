import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class BarberReviewItem extends StatelessWidget {
  const BarberReviewItem({
    super.key,
    required this.name,
    required this.rating,
    required this.comment,
    required this.image,
  });

  final String name;
  final double rating;
  final String comment;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: SizedBox(
              width: 44,
              height: 44,
              child: ColorFiltered(
                colorFilter: const ColorFilter.matrix([
                  .33,
                  .33,
                  .33,
                  0,
                  0,
                  .33,
                  .33,
                  .33,
                  0,
                  0,
                  .33,
                  .33,
                  .33,
                  0,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                ]),
                child: Image.asset(image, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.subHeadline2.copyWith(
                    color: AppColors.blueGray900,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: index == 4 ? 0 : 2),
                        child: SvgPicture.asset(
                          'lib/assets/icons/star-yellow.svg',
                          width: 14,
                          height: 14,
                          colorFilter: ColorFilter.mode(
                            index < rating
                                ? AppColors.secondary900
                                : AppColors.primary100,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${rating.toStringAsFixed(1)})',
                      style: AppTextStyles.caption1.copyWith(
                        color: AppColors.primary900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  comment,
                  style: AppTextStyles.body3.copyWith(
                    color: AppColors.primary600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
