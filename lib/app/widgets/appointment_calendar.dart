import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class AppointmentCalendar extends StatelessWidget {
  const AppointmentCalendar({
    super.key,
    required this.month,
    required this.selectedDate,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onDateSelected,
  });

  final DateTime month;
  final int selectedDate;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final ValueChanged<int> onDateSelected;

  static const _weekDays = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
  static const _monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  String get monthLabel => '${_monthNames[month.month - 1]} ${month.year}';

  List<DateTime> get calendarDates {
    final firstDay = DateTime(month.year, month.month);
    final leadingDays = firstDay.weekday % 7;
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final visibleDays = leadingDays + daysInMonth;
    final trailingDays = (7 - visibleDays % 7) % 7;
    final totalDays = visibleDays + trailingDays;

    return List.generate(
      totalDays,
      (index) => firstDay.add(Duration(days: index - leadingDays)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.blueGray100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: onPreviousMonth,
                icon: const Icon(
                  Icons.chevron_left,
                  color: AppColors.primary900,
                ),
              ),
              Expanded(
                child: Text(
                  monthLabel,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption1.copyWith(
                    color: AppColors.blueGray900,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: onNextMonth,
                icon: const Icon(
                  Icons.chevron_right,
                  color: AppColors.primary900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: _weekDays
              .map(
                (day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: AppTextStyles.caption2.copyWith(
                        color: AppColors.blueGray700,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 3),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: calendarDates.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisExtent: 40,
          ),
          itemBuilder: (context, index) {
            final date = calendarDates[index];
            final isCurrentMonth =
                date.year == month.year && date.month == month.month;
            final selected = isCurrentMonth && date.day == selectedDate;

            return Center(
              child: InkWell(
                onTap: isCurrentMonth ? () => onDateSelected(date.day) : null,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: selected
                      ? const BoxDecoration(
                          color: AppColors.primary900,
                          shape: BoxShape.circle,
                        )
                      : null,
                  child: Text(
                    date.day.toString().padLeft(2, '0'),
                    style: AppTextStyles.caption1.copyWith(
                      color: selected
                          ? AppColors.white
                          : isCurrentMonth
                          ? AppColors.blueGray900
                          : AppColors.primary200,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
