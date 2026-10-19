import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/widgets/home_barber_card.dart';
import 'package:salonhub_v2/app/widgets/home_map_card.dart';
import 'package:salonhub_v2/app/widgets/home_promo_card.dart';
import 'package:salonhub_v2/app/widgets/home_recommended_section.dart';
import 'package:salonhub_v2/app/widgets/home_section_header.dart';
import 'package:salonhub_v2/app/widgets/filter_bottom_sheet.dart';
import 'package:salonhub_v2/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 14),
              const HomePromoCard(),
              const SizedBox(height: 14),
              _buildSearchField(context),
              const SizedBox(height: 18),
              const HomeSectionHeader(title: 'Barbershop Terdekat'),
              const SizedBox(height: 10),
              ...controller.nearbyBarbers.map(
                (barber) => HomeBarberCard(
                  barber: barber,
                  showBooking: false,
                  showBorder: false,
                ),
              ),
              Center(
                child: OutlinedButton(
                  onPressed: () => Get.toNamed(Routes.FIND_BARBER),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary900,
                    side: const BorderSide(
                      color: AppColors.primary900,
                      width: 1.5,
                    ),
                    minimumSize: const Size(0, 48),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Lihat Semua',
                        style: AppTextStyles.headline4.copyWith(
                          color: AppColors.primary900,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        'lib/assets/icons/Square Arrow Right Up.svg',
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              HomeRecommendedSection(
                barbers: controller.recommendedBarbers,
                onSeeAll: controller.openRecommendedBarbers,
              ),
              const SizedBox(height: 6),
              HomeSectionHeader(
                title: 'Cari Barber di Sekitar',
                onSeeAll: () => Get.toNamed(Routes.FIND_BARBER),
              ),
              const SizedBox(height: 10),
              const HomeMapCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedNavIndex.value,
          onTap: controller.changeNavigation,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primary900,
          unselectedItemColor: AppColors.coolGray400,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          items: [
            _bottomBarItem('Beranda', 'lib/assets/icons/Home Smile.svg', 0),
            _bottomBarItem('Pesanan', 'lib/assets/icons/Calendar Mark.svg', 1),
            _bottomBarItem(
              'Pesan',
              'lib/assets/icons/Chat Round Unread.svg',
              2,
            ),
            _bottomBarItem('Profil', 'lib/assets/icons/User.svg', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.location_on, size: 20, color: AppColors.primary900),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medan',
              style: AppTextStyles.caption2.copyWith(
                color: AppColors.coolGray500,
              ),
            ),
            Text(
              'nabil',
              style: AppTextStyles.subHeadline3.copyWith(
                color: AppColors.coolGray900,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: 19,
          backgroundColor: AppColors.primary100,
          backgroundImage: const AssetImage('lib/assets/login_picture.png'),
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 42,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari barbershop atau layanan cukur...',
                hintStyle: AppTextStyles.caption1.copyWith(
                  color: AppColors.primary500,
                ),
                filled: true,
                fillColor: AppColors.blueGray100,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    'lib/assets/icons/search-normal.svg',
                    width: 17,
                    height: 17,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () => FilterBottomSheet.show(context),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primary900,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'lib/assets/icons/setting-4.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem _bottomBarItem(
    String label,
    String iconPath,
    int index,
  ) {
    final isActive = controller.selectedNavIndex.value == index;
    final iconColor = isActive ? AppColors.primary900 : AppColors.coolGray400;

    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        iconPath,
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
    );
  }
}
