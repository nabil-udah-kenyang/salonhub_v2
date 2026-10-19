import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class AuthPageLayout extends StatelessWidget {
  const AuthPageLayout({
    super.key,
    required this.title,
    required this.description,
    required this.child,
    this.topPadding = 70,
    this.titleStyle,
  });

  final String title;
  final String description;
  final Widget child;
  final double topPadding;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final keyboardIsOpen = MediaQuery.viewInsetsOf(context).bottom > 0;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF5F4),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                24,
                keyboardIsOpen ? 24 : topPadding,
                24,
                24 + MediaQuery.viewPaddingOf(context).bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      constraints.maxHeight -
                      (keyboardIsOpen ? 48 : topPadding + 24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: (titleStyle ?? AppTextStyles.headline1).copyWith(
                        color: AppColors.primary900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTextStyles.body3.copyWith(
                        color: AppColors.blueGray500,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 28),
                    child,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
