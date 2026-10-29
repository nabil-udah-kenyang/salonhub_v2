import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class AppointmentOrderSummary extends StatelessWidget {
  const AppointmentOrderSummary({
    super.key,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceFee,
    required this.totalPrice,
  });

  final String serviceName;
  final String servicePrice;
  final String serviceFee;
  final String totalPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SummaryRow(label: serviceName, price: servicePrice),
        const SizedBox(height: 10),
        _SummaryRow(label: 'Biaya layanan', price: serviceFee),
        const SizedBox(height: 12),
        const _DashedDivider(),
        const SizedBox(height: 12),
        _SummaryRow(
          label: 'Total pembayaran',
          price: totalPrice,
          emphasized: true,
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.price,
    this.emphasized = false,
  });

  final String label;
  final String price;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.body3.copyWith(
      color: AppColors.blueGray900,
      fontWeight: emphasized ? FontWeight.w700 : FontWeight.w500,
    );

    return Row(
      children: [
        Expanded(child: Text(label, style: style)),
        Text(price, style: style),
      ],
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      width: double.infinity,
      child: CustomPaint(painter: _DashedDividerPainter()),
    );
  }
}

class _DashedDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.blueGray300
      ..strokeWidth = 1;

    for (var start = 0.0; start < size.width; start += 8) {
      canvas.drawLine(Offset(start, 0), Offset(start + 4, 0), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
