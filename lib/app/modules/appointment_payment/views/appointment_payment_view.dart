import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/widgets/appointment_order_summary.dart';
import 'package:salonhub_v2/app/widgets/payment_method_card.dart';

import '../controllers/appointment_payment_controller.dart';

class AppointmentPaymentView extends GetView<AppointmentPaymentController> {
  const AppointmentPaymentView({super.key});

  static const _iconPath = 'lib/assets/icons/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coolGray50,
      body: SafeArea(
        left: false,
        right: false,
        child: Column(
          children: [
            _buildHero(),
            Expanded(
              child: GetBuilder<AppointmentPaymentController>(
                builder: (_) => _buildContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero() {
    return SizedBox(
      height: 226,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: AppColors.primary900),
          Opacity(
            opacity: .12,
            child: Image.asset(
              'lib/assets/barber_pattern_376x424.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: _buildShopSummary(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 62,
      child: Row(
        children: [
          IconButton(
            onPressed: Get.back,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 42, minHeight: 40),
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
          ),
          const SizedBox(width: 8),
          Text(
            'Janji Temu',
            style: AppTextStyles.headline4.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildShopSummary() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primary800.withValues(alpha: .72),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primary700),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'lib/assets/barbershop_haircut_2.jpg',
              width: 76,
              height: 76,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Masterpiece Barbershop - Haircut styling',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body3.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),
                _shopInfoRow(
                  icon: 'Map Point.svg',
                  text: 'Joga Expo Centre (2 km)',
                ),
                const SizedBox(height: 5),
                _shopInfoRow(icon: 'Star.svg', text: '5.0  (24)'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shopInfoRow({required String icon, required String text}) {
    return Row(
      children: [
        SvgPicture.asset(
          '$_iconPath$icon',
          width: 15,
          height: 15,
          colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption1.copyWith(
              color: AppColors.blueGray200,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.coolGray50,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(icon: 'Calendar Mark.svg', title: 'Tanggal & waktu'),
            const SizedBox(height: 8),
            Text(
              controller.appointmentDateLabel,
              style: AppTextStyles.body3.copyWith(color: AppColors.primary600),
            ),
            const SizedBox(height: 22),
            _sectionTitle(icon: 'Scissors.svg', title: 'Daftar layanan'),
            const SizedBox(height: 10),
            _buildServiceRow(
              image: controller.stylistImage,
              name: controller.serviceName,
              description: 'Stylist: ${controller.stylistName}',
              price: controller.formatRupiah(controller.servicePrice),
            ),
            const SizedBox(height: 22),
            _sectionTitle(icon: 'Wallet Money.svg', title: 'Metode pembayaran'),
            const SizedBox(height: 10),
            ...controller.paymentMethods.asMap().entries.map((entry) {
              final index = entry.key;
              final method = entry.value;

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == controller.paymentMethods.length - 1 ? 0 : 8,
                ),
                child: PaymentMethodCard(
                  name: method.name,
                  description: method.description,
                  image: method.image,
                  selected: controller.selectedPaymentIndex.value == index,
                  onTap: () => controller.selectPayment(index),
                ),
              );
            }),
            const SizedBox(height: 22),
            _sectionTitle(title: 'Ringkasan pembayaran'),
            const SizedBox(height: 10),
            AppointmentOrderSummary(
              serviceName: controller.serviceName,
              servicePrice: controller.formatRupiah(controller.servicePrice),
              serviceFee: controller.formatRupiah(controller.serviceFeePrice),
              totalPrice: controller.formatRupiah(controller.totalPrice),
            ),
            const SizedBox(height: 22),
            _buildPayButton(),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle({String? icon, required String title}) {
    return Row(
      children: [
        if (icon != null) ...[
          SvgPicture.asset(
            '$_iconPath$icon',
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(
              AppColors.primary900,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 6),
        ],
        Text(
          title,
          style: AppTextStyles.headline5.copyWith(color: AppColors.blueGray900),
        ),
      ],
    );
  }

  Widget _buildServiceRow({
    required String image,
    required String name,
    required String description,
    required String price,
  }) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(image, width: 48, height: 48, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.blueGray900,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: AppTextStyles.caption1.copyWith(
                  color: AppColors.blueGray500,
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
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: controller.proceedToPayment,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary900,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bayar sekarang',
              style: AppTextStyles.headline5.copyWith(color: AppColors.white),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              '${_iconPath}Wallet Money.svg',
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
