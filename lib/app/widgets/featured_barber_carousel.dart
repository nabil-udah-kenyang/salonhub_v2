import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/models/barber.dart';

import 'featured_barber.dart';

class FeaturedBarberCarousel extends StatefulWidget {
  const FeaturedBarberCarousel({
    super.key,
    required this.barbers,
    this.onBarberTap,
  });

  final List<Barber> barbers;
  final VoidCallback? onBarberTap;

  @override
  State<FeaturedBarberCarousel> createState() => _FeaturedBarberCarouselState();
}

class _FeaturedBarberCarouselState extends State<FeaturedBarberCarousel> {
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
              return FeaturedBarber(
                barber: widget.barbers[index],
                onTap: widget.onBarberTap,
              );
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
