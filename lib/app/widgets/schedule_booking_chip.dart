import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/modules/barber_detail/controllers/barber_detail_controller.dart';

class ScheduleBookingChip extends StatelessWidget {
  const ScheduleBookingChip({super.key, required this.booking});

  final ServiceBooking booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 126),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: booking.color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: SizedBox(
              width: 27,
              height: 27,
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
                child: Image.asset(booking.image, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption2.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  booking.service,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption2.copyWith(
                    color: AppColors.white,
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
