import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/routes/app_pages.dart';
import 'package:salonhub_v2/app/widgets/explore_barber_item.dart';
import 'package:salonhub_v2/app/widgets/featured_barber_carousel.dart';
import 'package:salonhub_v2/app/widgets/filter_bottom_sheet.dart';

import '../controllers/explore_barbers_controller.dart';

class ExploreBarbersView extends GetView<ExploreBarbersController> {
  const ExploreBarbersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 18),
              Obx(() {
                final barbers = controller.filteredBarbers;
                final selectedCategory = controller.selectedCategory.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (barbers.isNotEmpty) ...[
                      FeaturedBarberCarousel(
                        barbers: barbers.take(4).toList(),
                        onBarberTap: () => Get.toNamed(Routes.BARBER_DETAIL),
                      ),
                      const SizedBox(height: 16),
                    ],
                    _buildSearchField(context),
                    const SizedBox(height: 10),
                    _buildCategories(selectedCategory),
                    const SizedBox(height: 16),
                    if (barbers.length > 4)
                      ...barbers
                          .skip(4)
                          .map(
                            (barber) => ExploreBarberItem(
                              barber,
                              onTap: () => Get.toNamed(Routes.BARBER_DETAIL),
                            ),
                          ),
                    if (barbers.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: Center(child: Text('Barber tidak ditemukan.')),
                      ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back, color: AppColors.coolGray900),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 12),
        Text(
          'Explore Barbers',
          style: AppTextStyles.subHeadline3.copyWith(
            color: AppColors.coolGray900,
            fontWeight: FontWeight.w700,
          ),
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
              controller: controller.searchController,
              onChanged: controller.changeSearch,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Cari barbershop atau layanan cukur...',
                hintStyle: AppTextStyles.caption2.copyWith(
                  color: AppColors.primary500,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    'lib/assets/icons/search-normal.svg',
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      AppColors.blueGray500,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                filled: true,
                fillColor: AppColors.blueGray100,
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset('lib/assets/icons/setting-4.svg'),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories(int selectedCategory) {
    return SizedBox(
      height: 28,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        separatorBuilder: (_, index) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          final isSelected = selectedCategory == index;

          return ChoiceChip(
            label: Text(controller.categories[index]),
            selected: isSelected,
            onSelected: (_) => controller.changeCategory(index),
            labelStyle: AppTextStyles.caption2.copyWith(
              color: isSelected ? AppColors.primary900 : AppColors.coolGray500,
            ),
            backgroundColor: AppColors.white,
            selectedColor: AppColors.primary100,
            side: isSelected
                ? const BorderSide(color: AppColors.primary900)
                : BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            visualDensity: VisualDensity.compact,
            showCheckmark: false,
          );
        },
      ),
    );
  }
}
