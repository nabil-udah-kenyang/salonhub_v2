import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/widgets/appointment_order_summary.dart';
import 'package:salonhub_v2/app/widgets/invoice_action_buttons.dart';
import 'package:salonhub_v2/app/widgets/invoice_booking_summary.dart';
import 'package:salonhub_v2/app/widgets/invoice_success_hero.dart';

import '../controllers/invoice_controller.dart';

class InvoiceView extends GetView<InvoiceController> {
  const InvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coolGray50,
      body: SafeArea(
        left: false,
        right: false,
        child: Column(
          children: [
            InvoiceSuccessHero(onBack: Get.back),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.coolGray50,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 21, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InvoiceBookingSummary(
                        bookingDate: controller.bookingDate,
                        bookingCode: controller.bookingCode,
                        serviceName: controller.serviceName,
                      ),
                      const SizedBox(height: 18),
                      const Divider(color: AppColors.blueGray200, height: 1),
                      const SizedBox(height: 18),
                      Text(
                        'Ringkasan pembayaran',
                        style: AppTextStyles.headline5.copyWith(
                          color: AppColors.blueGray900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      AppointmentOrderSummary(
                        serviceName: controller.serviceName,
                        servicePrice: controller.formatRupiah(
                          controller.servicePrice,
                        ),
                        serviceFee: controller.formatRupiah(
                          controller.serviceFeePrice,
                        ),
                        totalPrice: controller.formatRupiah(
                          controller.totalPrice,
                        ),
                      ),
                      const SizedBox(height: 24),
                      GetBuilder<InvoiceController>(
                        builder: (invoiceController) {
                          return InvoiceActionButtons(
                            onBack: Get.back,
                            onDownload: invoiceController.downloadReceipt,
                            isDownloading: invoiceController.isDownloading,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
