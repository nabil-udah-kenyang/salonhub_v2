import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/modules/barber_detail/controllers/barber_detail_controller.dart';

import 'schedule_booking_chip.dart';

class TimelineRow extends StatelessWidget {
  const TimelineRow({super.key, required this.time, this.booking});

  final String time;
  final ServiceBooking? booking;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Row(
        children: [
          SizedBox(
            width: 62,
            child: Text(
              time,
              style: AppTextStyles.caption1.copyWith(
                color: AppColors.blueGray900,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 42,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 21,
                    child: Container(height: 1, color: AppColors.blueGray300),
                  ),
                  if (booking != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: ScheduleBookingChip(booking: booking!),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
