import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        controllers.length,
        (index) => SizedBox(
          width: 48,
          height: 48,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            autofocus: index == 0,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: AppTextStyles.body2.copyWith(
              color: AppColors.blueGray900,
              fontWeight: FontWeight.w700,
            ),
            onChanged: (_) => onChanged(index),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: const Color(0xFFE7F1F1),
              contentPadding: EdgeInsets.zero,
              border: _border(),
              enabledBorder: _border(),
              focusedBorder: _border(color: AppColors.primary900, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _border({
    Color color = AppColors.blueGray300,
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
