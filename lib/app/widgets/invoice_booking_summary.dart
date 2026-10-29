import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class InvoiceBookingSummary extends StatelessWidget {
  const InvoiceBookingSummary({
    super.key,
    required this.bookingDate,
    required this.bookingCode,
    required this.serviceName,
  });

  final String bookingDate;
  final String bookingCode;
  final String serviceName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Masterpiece Barbershop - Haircut styling',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.headline5.copyWith(
                  color: AppColors.blueGray900,
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 96,
              child: Text(
                bookingDate,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: AppTextStyles.caption1.copyWith(
                  color: AppColors.primary600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Text(
          serviceName,
          style: AppTextStyles.body3.copyWith(color: AppColors.blueGray500),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            style: AppTextStyles.caption1.copyWith(
              color: AppColors.blueGray500,
            ),
            children: [
              const TextSpan(text: 'Kode booking: '),
              TextSpan(
                text: bookingCode,
                style: AppTextStyles.caption1.copyWith(
                  color: AppColors.primary900,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
