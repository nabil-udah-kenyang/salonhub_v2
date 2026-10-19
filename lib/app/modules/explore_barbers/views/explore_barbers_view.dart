import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/models/barber.dart';
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
                      _FeaturedBarberCarousel(
                        barbers: barbers.take(4).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                    _buildSearchField(context),
                    const SizedBox(height: 10),
                    _buildCategories(selectedCategory),
                    const SizedBox(height: 16),
                    if (barbers.length > 4)
                      ...barbers.skip(4).map(_ExploreBarberItem.new),
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

class _FeaturedBarberCarousel extends StatefulWidget {
  const _FeaturedBarberCarousel({required this.barbers});

  final List<Barber> barbers;

  @override
  State<_FeaturedBarberCarousel> createState() =>
      _FeaturedBarberCarouselState();
}

class _FeaturedBarberCarouselState extends State<_FeaturedBarberCarousel> {
  late final PageController _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 270,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.barbers.length,
            onPageChanged: (index) {
              setState(() => _selectedPage = index);
            },
            itemBuilder: (context, index) {
              return _FeaturedBarber(barber: widget.barbers[index]);
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(widget.barbers.length, (index) {
            final isSelected = index == _selectedPage;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 26 : 8,
              height: 8,
              margin: const EdgeInsets.only(left: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary900
                    : AppColors.coolGray200,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _FeaturedBarber extends StatelessWidget {
  const _FeaturedBarber({required this.barber});

  final Barber barber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 180,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: AppColors.blueGray100),
                Image.asset(barber.image, fit: BoxFit.cover),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: const BoxDecoration(
                      color: AppColors.primary900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Pesan',
                          style: AppTextStyles.caption1.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          'lib/assets/icons/Calendar Mark.svg',
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          barber.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.subHeadline3.copyWith(
            color: AppColors.coolGray900,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        _InfoRow(
          iconAsset: 'lib/assets/icons/Map Point.svg',
          text: '${barber.description} (${barber.distance})',
        ),
        const SizedBox(height: 3),
        _InfoRow(iconAsset: 'lib/assets/icons/Star.svg', text: barber.rating),
      ],
    );
  }
}

class _ExploreBarberItem extends StatelessWidget {
  const _ExploreBarberItem(this.barber);

  final Barber barber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.asset(
              barber.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barber.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption1.copyWith(
                    color: AppColors.coolGray900,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                _InfoRow(
                  iconAsset: 'lib/assets/icons/Map Point.svg',
                  text: '${barber.description} (${barber.distance})',
                ),
                const SizedBox(height: 2),
                _InfoRow(
                  iconAsset: 'lib/assets/icons/Star.svg',
                  text: barber.rating,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.iconAsset, required this.text});

  final String iconAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconAsset,
          width: 13,
          height: 13,
          colorFilter: const ColorFilter.mode(
            AppColors.primary500,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption2.copyWith(
              color: AppColors.coolGray500,
            ),
          ),
        ),
      ],
    );
  }
}
