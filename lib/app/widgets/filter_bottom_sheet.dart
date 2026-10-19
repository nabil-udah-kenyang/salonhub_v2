import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FilterBottomSheet(),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final nearestController = TextEditingController(text: '0.1');
  final farthestController = TextEditingController(text: '10');

  String selectedCategory = 'Basic haircut';
  double minimumRating = 4;

  final categories = const [
    'Basic haircut',
    'Coloring',
    'Treatment',
    'Massage',
    'Kids haircut',
  ];

  @override
  void dispose() {
    nearestController.dispose();
    farthestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 20, 22, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategorySection(),
                      const SizedBox(height: 20),
                      _buildRatingSection(),
                      const SizedBox(height: 20),
                      _buildDistanceSection(),
                      const SizedBox(height: 20),
                      _buildApplyButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 10),
      color: AppColors.primary50,
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                'lib/assets/icons/Question Square.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Text(
            'Filter',
            style: AppTextStyles.headline3.copyWith(
              color: AppColors.coolGray900,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.coolGray300.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.close, size: 18, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('General Category'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: categories.map((category) {
            final isSelected = selectedCategory == category;

            return InkWell(
              onTap: () => setState(() => selectedCategory = category),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: isSelected
                    ? BoxDecoration(
                        border: Border.all(color: AppColors.primary900),
                        borderRadius: BorderRadius.circular(10),
                      )
                    : null,
                child: Text(
                  category,
                  style: AppTextStyles.body3.copyWith(
                    color: isSelected
                        ? AppColors.primary900
                        : AppColors.primary500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    const starSize = 28.0;
    const starSpacing = 10.0;
    const starsWidth = starSize * 5 + starSpacing * 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Rating Barber'),
        const SizedBox(height: 8),
        Row(
          children: [
            SizedBox(
              width: starsWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return InkWell(
                    onTap: () => setState(() => minimumRating = index + 1.0),
                    child: SvgPicture.asset(
                      index < minimumRating
                          ? 'lib/assets/icons/star-yellow.svg'
                          : 'lib/assets/icons/Star.svg',
                      width: starSize,
                      height: starSize,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '(${minimumRating.toStringAsFixed(1)})',
              style: AppTextStyles.body3.copyWith(color: AppColors.primary900),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primary900,
            inactiveTrackColor: AppColors.blueGray200,
            thumbColor: AppColors.primary900,
            overlayColor: AppColors.primary100,
            trackHeight: 8,
            tickMarkShape: SliderTickMarkShape.noTickMark,
          ),
          child: SizedBox(
            width: starsWidth,
            child: Slider(
              padding: EdgeInsets.zero,
              value: minimumRating,
              min: 0,
              max: 5,
              divisions: 10,
              onChanged: (value) {
                setState(() => minimumRating = value);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDistanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Distance'),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: _distanceField('Terdekat', nearestController)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: 24,
                height: 46,
                child: Center(
                  child: Text('–', style: TextStyle(fontSize: 20)),
                ),
              ),
            ),
            Expanded(child: _distanceField('Terjauh', farthestController)),
          ],
        ),
      ],
    );
  }

  Widget _distanceField(String label, TextEditingController textController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body3.copyWith(color: AppColors.primary500),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            SizedBox(
              width: 60,
              height: 46,
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: AppTextStyles.body3.copyWith(
                  color: AppColors.primary900,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: AppColors.primary900,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: AppColors.primary900,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'km',
              style: AppTextStyles.body3.copyWith(color: AppColors.primary900),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildApplyButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary900,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Terapkan',
          style: AppTextStyles.body3.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.headline4.copyWith(color: AppColors.coolGray900),
    );
  }
}
