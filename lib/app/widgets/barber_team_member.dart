import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class BarberTeamMember extends StatelessWidget {
  const BarberTeamMember({
    super.key,
    required this.name,
    required this.role,
    required this.rating,
    required this.image,
  });

  final String name;
  final String role;
  final String rating;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox(
              width: 38,
              height: 38,
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
                  role,
                  style: AppTextStyles.caption1.copyWith(
                    color: AppColors.coolGray500,
                  ),
                ),
              ],
            ),
          ),
          SvgPicture.asset('lib/assets/icons/Star.svg', width: 15, height: 15),
          const SizedBox(width: 4),
          Text(
            rating,
            style: AppTextStyles.caption1.copyWith(
              color: AppColors.coolGray500,
            ),
          ),
        ],
      ),
    );
  }
}
