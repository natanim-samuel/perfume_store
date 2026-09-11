import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color lightBg = Color(0xFFF5EFE6);
  static const Color lightSurface = Colors.white;
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightText = Color(0xFF1A1A1A);
  static const Color lightTextSub = Color(0xFF555555);
  static const Color lightTextHint = Color(0xFF888888);

  static const Color darkBg = Color(0xFF1A120B);
  static const Color darkSurface = Color(0xFF24180F);
  static const Color darkCard = Color(0xFF2F2117);
  static const Color darkBorder = Color(0xFF4A3422);

  static const Color darkText = Color(0xFFF5F1EA);
  static const Color darkTextSub = Color(0xFFD2C2B0);
  static const Color darkTextHint = Color(0xFF9A8572);

  static const Color accent = Color(0xFFD4A373);

  static const Color gold = Color(0xFFFFD700);
  static const Color goldDark = Color(0xFFC9A227);
  static const Color goldGlow = Color(0x66FFD700);

  static const List<Color> gardenColors = [
    Color(0xFF8B3A52), Color(0xFFCD6B85), Color(0xFF471B29),
  ];
  static const List<Color> shalimarColors = [
    Color(0xFFB8860B), Color(0xFFDAA520), Color(0xFF8B6914),
  ];
  static const List<Color> dreamsColors = [
    Color(0xFF6BEDC6), Color(0xFF5AE079), Color(0xFF386008),
  ];
  static const List<Color> ritualColors = [
    Color(0xFF6B2F8A), Color(0xFF8B3FAA), Color(0xFF4B1F6A),
  ];
}

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBg,
    useMaterial3: true,
    fontFamily: 'CormorantGaramond',
    colorScheme: const ColorScheme.light(
      primary: AppColors.goldDark,
      surface: AppColors.lightSurface,
    ),
    cardColor: AppColors.lightCard,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'CormorantGaramond', fontWeight: FontWeight.w300),
      displayMedium: TextStyle(fontFamily: 'CormorantGaramond', fontWeight: FontWeight.w300),
      bodyLarge: TextStyle(fontFamily: 'CormorantGaramond', fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontFamily: 'CormorantGaramond', fontWeight: FontWeight.w300),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBg,
    useMaterial3: true,
    fontFamily: 'CormorantGaramond',
    colorScheme: const ColorScheme.dark(
      primary: AppColors.gold,
      surface: AppColors.darkSurface,
    ),
    cardColor: AppColors.darkCard,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'CormorantGaramond', fontWeight: FontWeight.w300),
      displayMedium: TextStyle(fontFamily: 'CormorantGaramond', fontWeight: FontWeight.w300),
      bodyLarge: TextStyle(fontFamily: 'CormorantGaramond', fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontFamily: 'CormorantGaramond', fontWeight: FontWeight.w300),
    ),
  );
}

class AppConstants {
  AppConstants._();

  static const double spaceXS = 4.0;
  static const double spaceSM = 8.0;
  static const double spaceMD = 16.0;
  static const double spaceLG = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;

  static const double radiusSM = 8.0;
  static const double radiusMD = 16.0;
  static const double radiusLG = 24.0;
  static const double radiusXL = 32.0;
  static const double radiusFull = 100.0;

  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animNormal = Duration(milliseconds: 350);
  static const Duration animSlow = Duration(milliseconds: 500);

  static const String catAll = 'all';
  static const String catFemme = 'femme';
  static const String catVoyager = 'voyager';
  static const String catPerfum = 'perfum';
  static const String catHome = 'home';

  static const List<String> categories = [
    catAll, catFemme, catVoyager, catPerfum, catHome,
  ];

  static const String pidAqua = 'aqua';
  static const String pidGardens = 'gardens';
  static const String pidShalimar = 'shalimar';
  static const String pidDreams = 'dreams';
  static const String pidRitual = 'ritual';
}

extension AppThemeExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get bgColor => isDark ? AppColors.darkBg : AppColors.lightBg;
  Color get surfaceColor => isDark ? AppColors.darkSurface : AppColors.lightSurface;
  Color get cardColor => isDark ? AppColors.darkCard : AppColors.lightCard;
  Color get borderColor => isDark ? AppColors.darkBorder : AppColors.lightBorder;
  Color get textColor => isDark ? AppColors.darkText : AppColors.lightText;
  Color get textSubColor => isDark ? AppColors.darkTextSub : AppColors.lightTextSub;
  Color get textHintColor => AppColors.darkTextHint;
  Color get goldColor => isDark ? AppColors.gold : AppColors.goldDark;
  Color get goldGlow => AppColors.goldGlow;
}