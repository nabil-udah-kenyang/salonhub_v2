import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonhub_v2/app/widgets/app_primary_button.dart';
import 'package:salonhub_v2/app/widgets/app_text_field.dart';
import 'package:salonhub_v2/app/widgets/auth_page_layout.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      title: 'Lupa password?',
      description: 'Mohon Masukan Alamat email mu Yang terdaftar\nproses ulang',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            label: 'Email',
            hintText: 'nabil@gmail.com',
            iconPath: 'lib/assets/icons/Vector.svg',
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 24),
          AppPrimaryButton(label: 'Kirim', onPressed: controller.sendCode),
        ],
      ),
    );
  }
}
