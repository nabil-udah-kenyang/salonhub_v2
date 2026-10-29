import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/widgets/barber_detail_quick_action.dart';
import 'package:salonhub_v2/app/widgets/barber_detail_tab.dart';
import 'package:salonhub_v2/app/widgets/barber_review_item.dart';
import 'package:salonhub_v2/app/widgets/barber_service_item.dart';
import 'package:salonhub_v2/app/widgets/barber_team_member.dart';
import 'package:salonhub_v2/app/widgets/opening_hour_row.dart';
import 'package:salonhub_v2/app/widgets/timeline_row.dart';

import '../controllers/barber_detail_controller.dart';

class BarberDetailView extends GetView<BarberDetailController> {
  const BarberDetailView({super.key});

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
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: _buildContent(),
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
            'Detail Barber',
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: _buildShopSummary(),
        ),
        const SizedBox(height: 18),
        _buildTabs(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 17, 16, 0),
          child: _buildTabSection(),
        ),
      ],
    );
  }

  Widget _buildShopSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeroImage(),
        const SizedBox(height: 10),
        Text(
          controller.shopName,
          style: AppTextStyles.headline5.copyWith(color: AppColors.blueGray900),
        ),
        const SizedBox(height: 6),
        _infoRow(icon: 'Map Point.svg', text: controller.location),
        const SizedBox(height: 5),
        _infoRow(icon: 'Star.svg', text: controller.rating),
        const SizedBox(height: 17),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BarberDetailQuickAction(
              icon: 'logos_google-maps.svg',
              label: 'Maps',
            ),
            BarberDetailQuickAction(
              icon: 'Chat Round Unread purple.svg',
              label: 'Chat',
            ),
            BarberDetailQuickAction(icon: 'Share.svg', label: 'Share'),
            BarberDetailQuickAction(icon: 'Heart.svg', label: 'Favorite'),
          ],
        ),
      ],
    );
  }

  Widget _buildTabSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          switch (controller.selectedTab.value) {
            case 1:
              return _buildServiceTab();
            case 2:
              return _buildScheduleTab();
            case 3:
              return _buildReviewTab();
            default:
              return _buildAboutTab();
          }
        }),
        const SizedBox(height: 10),
        _buildBookingButton(),
      ],
    );
  }

  Widget _buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: AppTextStyles.body3.copyWith(color: AppColors.blueGray900),
            children: [
              TextSpan(text: '${controller.description} '),
              TextSpan(
                text: 'Read more...',
                style: AppTextStyles.body3.copyWith(
                  color: AppColors.primary900,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _buildOpeningHours(),
        const SizedBox(height: 14),
        Text(
          'Our Team',
          style: AppTextStyles.headline5.copyWith(color: AppColors.blueGray900),
        ),
        const SizedBox(height: 10),
        ...controller.teamMembers.map(
          (member) => BarberTeamMember(
            name: member.name,
            role: member.role,
            rating: member.rating,
            image: member.image,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Service',
          style: AppTextStyles.headline5.copyWith(color: AppColors.blueGray900),
        ),
        const SizedBox(height: 10),
        ...controller.services.map(
          (service) => BarberServiceItem(
            name: service.name,
            description: service.description,
            price: service.price,
            image: service.image,
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              '${_iconPath}Calendar Mark.svg',
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                AppColors.primary900,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              controller.scheduleDate,
              style: AppTextStyles.headline5.copyWith(
                color: AppColors.blueGray900,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: AppColors.blueGray900,
            ),
          ],
        ),
        const SizedBox(height: 13),
        Text(
          'Timeline',
          style: AppTextStyles.body3.copyWith(
            color: AppColors.blueGray900,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        ...controller.scheduleTimes.map(
          (time) => TimelineRow(time: time, booking: _bookingAt(time)),
        ),
      ],
    );
  }

  Widget _buildReviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...controller.reviews.map(
          (review) => BarberReviewItem(
            name: review.name,
            rating: review.rating,
            comment: review.comment,
            image: review.image,
          ),
        ),
      ],
    );
  }

  ServiceBooking? _bookingAt(String time) {
    for (final booking in controller.scheduleBookings) {
      if (booking.time == time) {
        return booking;
      }
    }

    return null;
  }

  Widget _buildBookingButton() {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: FilledButton(
        onPressed: controller.bookNow,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary900,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: Text(
          'Booking Now',
          style: AppTextStyles.headline5.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  Widget _buildHeroImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 174,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(controller.shopImage, fit: BoxFit.cover),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.teal500,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7),
                  ),
                ),
                child: Text(
                  'Open',
                  style: AppTextStyles.caption1.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow({required String icon, required String text}) {
    return Row(
      children: [
        SvgPicture.asset(
          '$_iconPath$icon',
          width: 16,
          height: 16,
          colorFilter: const ColorFilter.mode(
            AppColors.primary500,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: AppTextStyles.caption1.copyWith(color: AppColors.primary500),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.primary50,
      child: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 92,
                child: BarberDetailTab(
                  label: 'About',
                  icon: 'People Nearby.svg',
                  selected: controller.selectedTab.value == 0,
                  onTap: () => controller.selectTab(0),
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                width: 92,
                child: BarberDetailTab(
                  label: 'Service',
                  icon: 'Scissors.svg',
                  selected: controller.selectedTab.value == 1,
                  onTap: () => controller.selectTab(1),
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                width: 100,
                child: BarberDetailTab(
                  label: 'Schedule',
                  icon: 'Calendar Mark.svg',
                  selected: controller.selectedTab.value == 2,
                  onTap: () => controller.selectTab(2),
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(
                width: 92,
                child: BarberDetailTab(
                  label: 'Review',
                  icon: 'Star.svg',
                  selected: controller.selectedTab.value == 3,
                  onTap: () => controller.selectTab(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOpeningHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Opening Hours',
          style: AppTextStyles.headline5.copyWith(color: AppColors.blueGray900),
        ),
        const SizedBox(height: 7),
        for (
          var index = 0;
          index < controller.openingHours.length;
          index++
        ) ...[
          if (index > 0) const SizedBox(height: 5),
          OpeningHourRow(
            day: controller.openingHours[index].day,
            hours: controller.openingHours[index].hours,
          ),
        ],
      ],
    );
  }
}
