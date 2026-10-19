import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/widgets/app_primary_button.dart';
import 'package:salonhub_v2/app/widgets/app_text_field.dart';

import '../controllers/login_screen_controller.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    final keyboardIsOpen = keyboardHeight > 0;
    final availableHeight = screenHeight - keyboardHeight;

    final imageHeight = keyboardIsOpen
        ? availableHeight * 0.28
        : availableHeight * 0.43;

    final panelTop = keyboardIsOpen
        ? availableHeight * 0.22
        : availableHeight * 0.43;

    return Scaffold(
      backgroundColor: AppColors.coolGray700,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('lib/assets/background2.png', fit: BoxFit.cover),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: imageHeight,
            child: Image.asset(
              'lib/assets/login_picture.png',
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Positioned(
            top: panelTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                24,
                24,
                24,
                24 + MediaQuery.viewPaddingOf(context).bottom,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFEAF5F4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back ',
                      style: AppTextStyles.headline1.copyWith(
                        color: AppColors.primary900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Silahkan Masukan Informasi Loginmu\n'
                      'Untuk Mengakses Akunmu',
                      style: AppTextStyles.body3.copyWith(
                        color: AppColors.blueGray500,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 22),
                    const AppTextField(
                      label: 'Username',
                      hintText: 'nabil@gmail.com',
                      iconPath: 'lib/assets/icons/Vector.svg',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 18),
                    Obx(
                      () => AppTextField(
                        label: 'Password',
                        hintText: '********',
                        iconPath: 'lib/assets/icons/Key Minimalistic.svg',
                        obscureText: controller.isPasswordObscured.value,
                        textInputAction: TextInputAction.done,
                        suffixIcon: IconButton(
                          onPressed: controller.togglePasswordVisibility,
                          icon: Icon(
                            controller.isPasswordObscured.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                            color: AppColors.primary900,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: controller.openForgotPassword,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(top: 8),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Lupa password?',
                          style: AppTextStyles.subHeadline3.copyWith(
                            color: AppColors.primary900,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AppPrimaryButton(
                      label: 'Login',
                      onPressed: controller.login,
                    ),
                    const SizedBox(height: 22),
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            "Belum Punya Akun ? ",
                            style: AppTextStyles.body3.copyWith(
                              color: AppColors.blueGray500,
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.openRegister,
                            child: Text(
                              'Daftar',
                              style: AppTextStyles.body3.copyWith(
                                color: AppColors.primary900,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
