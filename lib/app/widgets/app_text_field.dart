import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.iconPath,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
  });

  final String label;
  final String hintText;
  final String? iconPath;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.subHeadline3.copyWith(
            color: AppColors.blueGray900,
          ),
        ),
        const SizedBox(height: 7),
        SizedBox(
          height: 48,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscureText,
            onChanged: onChanged,
            style: AppTextStyles.body3.copyWith(color: AppColors.blueGray900),
            decoration: _inputDecoration(),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyles.body3.copyWith(color: AppColors.blueGray400),
      filled: true,
      fillColor: const Color(0xFFE7F1F1),
      prefixIcon:
          prefixIcon ??
          Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              iconPath!,
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                AppColors.primary900,
                BlendMode.srcIn,
              ),
            ),
          ),
      prefixIconConstraints: prefixIconConstraints,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      border: _inputBorder(),
      enabledBorder: _inputBorder(),
      focusedBorder: _inputBorder(color: AppColors.primary900, width: 1.5),
    );
  }

  OutlineInputBorder _inputBorder({
    Color color = AppColors.blueGray300,
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
