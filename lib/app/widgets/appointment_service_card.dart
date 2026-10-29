import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class AppointmentServiceCard extends StatelessWidget {
  const AppointmentServiceCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final String price;
  final String image;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 84,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipOval(
                  child: selected
                      ? ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            AppColors.primary900.withValues(alpha: .45),
                            BlendMode.srcATop,
                          ),
                          child: Image.asset(
                            image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                ),
                if (selected)
                  SvgPicture.asset(
                    'lib/assets/icons/ceklis_putih.svg',
                    width: 24,
                    height: 18,
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              name,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption1.copyWith(
                color: AppColors.blueGray900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              price,
              style: AppTextStyles.caption1.copyWith(
                color: AppColors.primary500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
