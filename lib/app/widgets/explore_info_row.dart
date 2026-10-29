import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class ExploreInfoRow extends StatelessWidget {
  const ExploreInfoRow({
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
        SvgPicture.asset(
          iconAsset,
          width: 13,
          height: 13,
          colorFilter: const ColorFilter.mode(
            AppColors.primary500,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption2.copyWith(
              color: AppColors.coolGray500,
            ),
          ),
        ),
      ],
    );
  }
}
