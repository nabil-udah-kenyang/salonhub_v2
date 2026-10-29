import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/widgets/appointment_calendar.dart';
import 'package:salonhub_v2/app/widgets/appointment_payment_summary.dart';
import 'package:salonhub_v2/app/widgets/appointment_service_option_card.dart';
import 'package:salonhub_v2/app/widgets/appointment_stylist_card.dart';
import 'package:salonhub_v2/app/widgets/appointment_time_chip.dart';

import '../controllers/book_appointment_controller.dart';

class BookAppointmentView extends GetView<BookAppointmentController> {
  const BookAppointmentView({super.key});

  static const _iconPath = 'lib/assets/icons/';

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
              child: GetBuilder<BookAppointmentController>(
                builder: (_) => SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                  child: _buildContent(),
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
            'Booking',
            style: AppTextStyles.headline4.copyWith(
              color: AppColors.blueGray900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Pilih tanggal'),
        const SizedBox(height: 10),
        AppointmentCalendar(
          month: controller.displayedMonth.value,
          selectedDate: controller.selectedDate.value,
          onPreviousMonth: controller.previousMonth,
          onNextMonth: controller.nextMonth,
          onDateSelected: controller.selectDate,
        ),
        const SizedBox(height: 22),
        _sectionTitle('Pilih stylist'),
        const SizedBox(height: 10),
        _buildStylists(),
        const SizedBox(height: 22),
        _sectionTitle('Pilih layanan'),
        const SizedBox(height: 10),
        _buildServices(),
        const SizedBox(height: 22),
        _sectionTitle('Waktu tersedia'),
        const SizedBox(height: 10),
        _buildAvailableTimes(),
        const SizedBox(height: 22),
        _sectionTitle('Ringkasan pembayaran'),
        const SizedBox(height: 10),
        AppointmentPaymentSummary(
          serviceName: controller.selectedServiceName,
          servicePrice: controller.servicePrice,
          serviceFee: controller.serviceFeePrice,
        ),
        const SizedBox(height: 22),
        _buildBookingButton(),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.headline5.copyWith(color: AppColors.blueGray900),
    );
  }

  Widget _buildStylists() {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.stylists.length,
        separatorBuilder: (_, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final stylist = controller.stylists[index];

          return AppointmentStylistCard(
            name: stylist.name,
            specialty: stylist.specialty,
            image: stylist.image,
            selected: controller.selectedStylistIndex.value == index,
            onTap: () => controller.selectStylist(index),
          );
        },
      ),
    );
  }

  Widget _buildServices() {
    return Column(
      children: controller.services.asMap().entries.map((entry) {
        final index = entry.key;
        final service = entry.value;

        return Padding(
          padding: EdgeInsets.only(
            bottom: index == controller.services.length - 1 ? 0 : 8,
          ),
          child: AppointmentServiceOptionCard(
            name: service.name,
            description: service.description,
            price: controller.formatRupiah(service.price),
            selected: controller.selectedServiceIndexes.contains(index),
            onTap: () => controller.selectService(index),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAvailableTimes() {
    return Wrap(
      spacing: 8,
      runSpacing: 9,
      children: controller.availableTimes.map((time) {
        final enabled = !controller.unavailableTimes.contains(time);

        return AppointmentTimeChip(
          time: time,
          selected: controller.selectedTime.value == time,
          enabled: enabled,
          onTap: () => controller.selectTime(time),
        );
      }).toList(),
    );
  }

  Widget _buildBookingButton() {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: FilledButton(
        onPressed: controller.submitBooking,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary900,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Booking',
              style: AppTextStyles.headline5.copyWith(color: AppColors.white),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              '${_iconPath}Calendar Mark putih.svg',
              width: 17,
              height: 17,
            ),
          ],
        ),
      ),
    );
  }
}
