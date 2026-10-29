import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coolGray100,
      body: SafeArea(
        left: false,
        right: false,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  children: [
                    _buildWaitingAnimation(),
                    const SizedBox(height: 6),
                    Text(
                      'Menunggu pembayaran',
                      style: AppTextStyles.headline4.copyWith(
                        color: AppColors.blueGray900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Selesaikan pembayaran untuk mengonfirmasi janji temu.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body3.copyWith(
                        color: AppColors.blueGray500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    controller.isQris
                        ? _buildQrisPayment()
                        : _buildBankPayment(),
                    const SizedBox(height: 18),
                    _buildTotalCard(),
                    const SizedBox(height: 20),
                    _buildPaidButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 62,
      color: AppColors.blueGray50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          IconButton(
            onPressed: Get.back,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 40),
            icon: const Icon(Icons.arrow_back, color: AppColors.blueGray900),
          ),
          const SizedBox(width: 10),
          Text(
            'Pembayaran',
            style: AppTextStyles.headline4.copyWith(
              color: AppColors.blueGray900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaitingAnimation() {
    return SizedBox(
      width: double.infinity,
      height: 170,
      child: Lottie.asset(
        'lib/assets/lottie/Waiting.json',
        width: 150,
        height: 150,
        repeat: true,
        delegates: LottieDelegates(
          values: [
            ValueDelegate.color(const [
              '**',
              'Fill 1',
            ], value: AppColors.primary900),
            ValueDelegate.color(const [
              'Bulet',
              'Ellipse 1',
              'Stroke 1',
            ], value: AppColors.primary700),
          ],
        ),
      ),
    );
  }

  Widget _buildQrisPayment() {
    return _paymentCard(
      children: [
        SvgPicture.asset(
          controller.methodImage,
          width: 96,
          height: 32,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 14),
        Text(
          'Scan QRIS untuk membayar',
          style: AppTextStyles.headline5.copyWith(color: AppColors.blueGray900),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.blueGray200),
          ),
          child: SvgPicture.asset(
            'lib/assets/icons/qris_payment_code.svg',
            width: 190,
            height: 190,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Buka aplikasi pembayaran dan arahkan kamera ke kode QR.',
          textAlign: TextAlign.center,
          style: AppTextStyles.caption1.copyWith(color: AppColors.blueGray500),
        ),
      ],
    );
  }

  Widget _buildBankPayment() {
    return _paymentCard(
      children: [
        Container(
          height: 58,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.blueGray50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(controller.methodImage, fit: BoxFit.contain),
        ),
        const SizedBox(height: 14),
        Text(
          'Kode pembayaran',
          style: AppTextStyles.headline5.copyWith(color: AppColors.blueGray900),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: AppColors.blueGray50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.blueGray200),
          ),
          child: Text(
            controller.paymentCode,
            textAlign: TextAlign.center,
            style: AppTextStyles.headline3.copyWith(
              color: AppColors.primary900,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 9),
        Text(
          'Gunakan kode ini saat melakukan transfer melalui ${controller.methodName}.',
          textAlign: TextAlign.center,
          style: AppTextStyles.caption1.copyWith(color: AppColors.blueGray500),
        ),
      ],
    );
  }

  Widget _paymentCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.blueGray200),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTotalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Total pembayaran',
              style: AppTextStyles.body3.copyWith(
                color: AppColors.blueGray900,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            controller.formatRupiah(controller.totalPrice),
            style: AppTextStyles.headline5.copyWith(
              color: AppColors.primary900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaidButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: controller.markAsPaid,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary900,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: Text(
          'Sudah bayar',
          style: AppTextStyles.headline5.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
