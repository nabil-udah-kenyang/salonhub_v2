import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/models/barber.dart';

class HomeRecommendedSection extends StatefulWidget {
  const HomeRecommendedSection({
    super.key,
    required this.barbers,
    this.onSeeAll,
    this.onBarberTap,
  });

  final List<Barber> barbers;
  final VoidCallback? onSeeAll;
  final VoidCallback? onBarberTap;

  @override
  State<HomeRecommendedSection> createState() => _HomeRecommendedSectionState();
}

class _HomeRecommendedSectionState extends State<HomeRecommendedSection> {
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
    if (widget.barbers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Paling Direkomendasikan',
          style: TextStyle(
            color: AppColors.coolGray900,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 294,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.barbers.length,
            onPageChanged: (index) {
              setState(() => _selectedPage = index);
            },
            itemBuilder: (context, index) {
              return _FeaturedBarberCard(
                barber: widget.barbers[index],
                onTap: widget.onBarberTap,
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        _buildPageIndicator(),
        const SizedBox(height: 14),
        ...widget.barbers
            .skip(1)
            .map(
              (barber) =>
                  _RecommendedBarberItem(barber, onTap: widget.onBarberTap),
            ),
        const SizedBox(height: 2),
        Center(
          child: OutlinedButton(
            onPressed: widget.onSeeAll,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary900,
              side: const BorderSide(color: AppColors.primary900, width: 1.5),
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
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(widget.barbers.length, (index) {
        final isSelected = index == _selectedPage;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isSelected ? 26 : 8,
          height: 8,
          margin: const EdgeInsets.only(left: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary900 : AppColors.coolGray200,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}

class _FeaturedBarberCard extends StatelessWidget {
  const _FeaturedBarberCard({required this.barber, this.onTap});

  final Barber barber;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 198,
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
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
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
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 15,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
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
            icon: Icons.location_on,
            text: '${barber.description} (${barber.distance})',
          ),
          const SizedBox(height: 3),
          _InfoRow(iconAsset: 'lib/assets/icons/Star.svg', text: barber.rating),
        ],
      ),
    );
  }
}

class _RecommendedBarberItem extends StatelessWidget {
  const _RecommendedBarberItem(this.barber, {this.onTap});

  final Barber barber;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                barber.image,
                width: 92,
                height: 92,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    barber.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.subHeadline3.copyWith(
                      color: AppColors.coolGray900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  _InfoRow(
                    icon: Icons.location_on,
                    text: '${barber.description} (${barber.distance})',
                  ),
                  const SizedBox(height: 4),
                  _InfoRow(
                    iconAsset: 'lib/assets/icons/Star.svg',
                    text: barber.rating,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({this.icon, this.iconAsset, required this.text});

  final IconData? icon;
  final String? iconAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (iconAsset != null)
          SvgPicture.asset(iconAsset!, width: 14, height: 14)
        else
          Icon(icon, size: 14, color: AppColors.coolGray500),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption1.copyWith(
              color: AppColors.coolGray500,
            ),
          ),
        ),
      ],
    );
  }
}
