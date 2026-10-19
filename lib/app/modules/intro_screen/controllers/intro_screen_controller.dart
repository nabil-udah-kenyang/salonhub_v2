import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonhub_v2/app/routes/app_pages.dart';

class IntroScreenController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  final pages = const [
    IntroPageData(
      image: 'lib/assets/intro1.png',
      imageBottomOffset: 26,
      title: 'Welcome Salonhubers',
      description:
          'Temukan pengalaman grooming terbaik di kotamu hanya dengan satu ketukan! Jangan lewatkan potongan rambut atau perawatan impianmu. Yuk, mulai sekarang!',
    ),
    IntroPageData(
      image: 'lib/assets/intro2.png',
      title: 'Pilih Layanan favoritemu',
      description: 'Pilih layanan grooming terbaik sesuai dengan kebutuhanmu.',
    ),
    IntroPageData(
      image: 'lib/assets/intro3.png',
      imageBottomOffset: 26,
      title: 'Booking Dengan Mudah',
      description: 'Pesan jadwalmu dengan mudah dan nikmati layanan terbaik.',
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value == pages.length - 1) {
      Get.offNamed(Routes.LOGIN_SCREEN);
      return;
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class IntroPageData {
  final String image;
  final double imageBottomOffset;
  final String title;
  final String description;

  const IntroPageData({
    required this.image,
    this.imageBottomOffset = 0,
    required this.title,
    required this.description,
  });
}
