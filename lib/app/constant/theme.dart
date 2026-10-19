import 'package:flutter/material.dart';

/// Semua warna yang tersedia pada design system dari Figma.
abstract final class AppColors {
  AppColors._();

  static const white = Color(0xFFFFFFFF);

  // Neutral / Cool Gray
  static const coolGray900 = Color(0xFF111827);
  static const coolGray800 = Color(0xFF1F2937);
  static const coolGray700 = Color(0xFF374151);
  static const coolGray600 = Color(0xFF4B5563);
  static const coolGray500 = Color(0xFF6B7280);
  static const coolGray400 = Color(0xFF9CA3AF);
  static const coolGray300 = Color(0xFFD1D5DB);
  static const coolGray200 = Color(0xFFE5E7EB);
  static const coolGray100 = Color(0xFFF4F4F5);
  static const coolGray50 = Color(0xFFF9FAFB);

  // Neutral Blue Gray
  static const blueGray900 = Color(0xFF0F172A);
  static const blueGray800 = Color(0xFF1E293B);
  static const blueGray700 = Color(0xFF334155);
  static const blueGray600 = Color(0xFF475569);
  static const blueGray500 = Color(0xFF64748B);
  static const blueGray400 = Color(0xFF94A3B8);
  static const blueGray300 = Color(0xFFCBD5E1);
  static const blueGray200 = Color(0xFFE2E8F0);
  static const blueGray100 = Color(0xFFEBF0F5);
  static const blueGray50 = Color(0xFFF8FAFC);

  // Primary / Brand
  static const primary900 = Color(0xFF363062);
  static const primary800 = Color(0xFF4A4572);
  static const primary700 = Color(0xFF5E5981);
  static const primary600 = Color(0xFF726E91);
  static const primary500 = Color(0xFF8683A1);
  static const primary400 = Color(0xFF9A97B0);
  static const primary300 = Color(0xFFAFACC0);
  static const primary200 = Color(0xFFC3C1D0);
  static const primary100 = Color(0xFFD7D6E0);
  static const primary50 = Color(0xFFEBEAEF);

  // Secondary / Orange
  static const secondary900 = Color(0xFFF99417);
  static const secondary800 = Color(0xFFFA9F2E);
  static const secondary700 = Color(0xFFFAA945);
  static const secondary600 = Color(0xFFFBB45D);
  static const secondary500 = Color(0xFFFBBF74);
  static const secondary400 = Color(0xFFFCC98B);
  static const secondary300 = Color(0xFFFDD4A2);
  static const secondary200 = Color(0xFFFDDFB9);
  static const secondary100 = Color(0xFFFEEAD1);
  static const secondary50 = Color(0xFFFEF4E8);

  // Accent / Pink
  static const accent900 = Color(0xFFFF4AAB);
  static const accent800 = Color(0xFFFF5CB3);
  static const accent700 = Color(0xFFFF6EBC);
  static const accent600 = Color(0xFFFF80C4);
  static const accent500 = Color(0xFFFF92CD);
  static const accent400 = Color(0xFFFFA5D5);
  static const accent300 = Color(0xFFFFB7DD);
  static const accent200 = Color(0xFFFFC9E6);
  static const accent100 = Color(0xFFFFDBEE);
  static const accent50 = Color(0xFFFFEDF7);

  // Red / Warning / Fail
  static const red900 = Color(0xFF881337);
  static const red800 = Color(0xFF9F1239);
  static const red700 = Color(0xFFBE123C);
  static const red600 = Color(0xFFE11D48);
  static const red500 = Color(0xFFF43F5E);
  static const red400 = Color(0xFFFB7185);
  static const red300 = Color(0xFFFDA4AF);
  static const red200 = Color(0xFFFECDD3);
  static const red100 = Color(0xFFFFE4E6);
  static const red50 = Color(0xFFFFF1F2);

  // Yellow / On Process
  static const yellow900 = Color(0xFF713F12);
  static const yellow800 = Color(0xFF854D0E);
  static const yellow700 = Color(0xFFA16207);
  static const yellow600 = Color(0xFFCA8A04);
  static const yellow500 = Color(0xFFEAB308);
  static const yellow400 = Color(0xFFFACC15);
  static const yellow300 = Color(0xFFFDE047);
  static const yellow200 = Color(0xFFFEF08A);
  static const yellow100 = Color(0xFFFEF9C3);
  static const yellow50 = Color(0xFFFEFCE8);

  // Blue
  static const blue900 = Color(0xFF0C4A6E);
  static const blue800 = Color(0xFF075985);
  static const blue700 = Color(0xFF0369A1);
  static const blue600 = Color(0xFF0284C7);
  static const blue500 = Color(0xFF0EA5E9);
  static const blue400 = Color(0xFF38BDF8);
  static const blue300 = Color(0xFF7DD3FC);
  static const blue200 = Color(0xFFBAE6FD);
  static const blue100 = Color(0xFFE0F2FE);
  static const blue50 = Color(0xFFF0F9FF);

  // Teal Green / Success
  static const teal900 = Color(0xFF134E4A);
  static const teal800 = Color(0xFF115E59);
  static const teal700 = Color(0xFF0F766E);
  static const teal600 = Color(0xFF0D9488);
  static const teal500 = Color(0xFF14B8A6);
  static const teal400 = Color(0xFF2DD4BF);
  static const teal300 = Color(0xFF5EEAD4);
  static const teal200 = Color(0xFF99F6E4);
  static const teal100 = Color(0xFFCCFBF1);
  static const teal50 = Color(0xFFF0FDFA);
}

/// Typography dari guideline Figma.
///
/// SVG Figma menyebutkan Plus Jakarta Sans. Font-nya dibundel sebagai asset
/// lokal agar hasilnya konsisten di semua device.
abstract final class AppTextStyles {
  AppTextStyles._();

  static const fontFamily = 'Plus Jakarta Sans';

  static const display1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  static const display2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  static const headline1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  static const headline2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  static const headline3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  static const headline4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  static const headline5 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  static const subHeadline1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );

  static const subHeadline2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );

  static const subHeadline3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );

  static const body1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const body2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const body3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const caption1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const caption2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static final textTheme =
      TextTheme(
        displayLarge: display1,
        displayMedium: display2,
        headlineLarge: headline1,
        headlineMedium: headline2,
        headlineSmall: headline3,
        titleLarge: headline4,
        titleMedium: headline5,
        bodyLarge: body1,
        bodyMedium: body2,
        bodySmall: body3,
        labelLarge: caption1,
        labelMedium: caption2,
      ).apply(
        bodyColor: AppColors.coolGray900,
        displayColor: AppColors.coolGray900,
      );
}

abstract final class AppTheme {
  AppTheme._();

  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: AppTextStyles.fontFamily,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary900,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.primary50,
      onPrimaryContainer: AppColors.primary900,
      secondary: AppColors.secondary900,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.secondary50,
      onSecondaryContainer: AppColors.secondary900,
      tertiary: AppColors.accent900,
      onTertiary: AppColors.white,
      tertiaryContainer: AppColors.accent50,
      onTertiaryContainer: AppColors.accent900,
      error: AppColors.red700,
      onError: AppColors.white,
      errorContainer: AppColors.red50,
      onErrorContainer: AppColors.red900,
      surface: AppColors.white,
      onSurface: AppColors.coolGray900,
      surfaceContainerHighest: AppColors.coolGray100,
      onSurfaceVariant: AppColors.coolGray600,
      outline: AppColors.coolGray400,
      outlineVariant: AppColors.coolGray200,
      inverseSurface: AppColors.coolGray900,
      onInverseSurface: AppColors.white,
      inversePrimary: AppColors.primary200,
    ),
    scaffoldBackgroundColor: AppColors.white,
    textTheme: AppTextStyles.textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.coolGray900,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.headline4,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.coolGray50,
      hintStyle: AppTextStyles.body3.copyWith(color: AppColors.coolGray400),
      labelStyle: AppTextStyles.body3.copyWith(color: AppColors.coolGray600),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.coolGray200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.coolGray200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary900, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red500),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary900,
        foregroundColor: AppColors.white,
        textStyle: AppTextStyles.subHeadline3,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary900,
        foregroundColor: AppColors.white,
        textStyle: AppTextStyles.subHeadline3,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
