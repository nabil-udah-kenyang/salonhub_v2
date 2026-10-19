import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonhub_v2/app/widgets/app_primary_button.dart';
import 'package:salonhub_v2/app/widgets/auth_page_layout.dart';
import 'package:salonhub_v2/app/widgets/otp_input.dart';

import '../controllers/otp_screen_controller.dart';

class OtpScreenView extends GetView<OtpScreenController> {
  const OtpScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPageLayout(
      title: 'Authentication',
      description:
          'Silahkan Masukan Kode OTP\nYang Telah Kami Kirim Ke emailmu',
      child: Column(
        children: [
          OtpInput(
            controllers: controller.otpControllers,
            focusNodes: controller.otpFocusNodes,
            onChanged: controller.onOtpChanged,
          ),
          const SizedBox(height: 24),
          AppPrimaryButton(label: 'Kirim', onPressed: controller.sendCode),
          const SizedBox(height: 24),
          TextButton(
            onPressed: controller.sendCode,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Belum Menerima Kode?'),
          ),
        ],
      ),
    );
  }
}
