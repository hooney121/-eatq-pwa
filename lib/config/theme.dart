import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 주요 색상 정의
  static const Color primaryColor = Color(0xFFE65100);  // 짙은 오렌지
  static const Color primaryLightColor = Color(0xFFFFA726);  // 라이트 오렌지
  static const Color secondaryColor = Color(0xFF8D6E63);  // 브라운
  static const Color accentColor = Color(0xFF26A69A);  // 민트 그린 (포인트 색)

  // 배경 및 카드 색상
  static const Color backgroundColor = Color(0xFFFAFAFA);  // 약간 따뜻한 백색
  static const Color cardColor = Colors.white;
  static const Color surfaceColor = Colors.white;

  // 텍스트 색상
  static const Color primaryTextColor = Color(0xFF212121);  // 거의 검정
  static const Color secondaryTextColor = Color(0xFF757575);  // 중간 회색
  static const Color disabledTextColor = Color(0xFFBDBDBD);  // 밝은 회색

  // 기타 색상
  static const Color errorColor = Color(0xFFD32F2F);  // 붉은색 (에러)
  static const Color successColor = Color(0xFF388E3C);  // 초록색 (성공)
  static const Color warningColor = Color(0xFFFFA000);  // 주황색 (경고)

  // 그라데이션
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFE65100), Color(0xFFFF9800)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // 라이트 테마 정의
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      background: backgroundColor,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: primaryTextColor,
      onBackground: primaryTextColor,
      onError: Colors.white,
      brightness: Brightness.light,
    ),

    // 텍스트 테마
    textTheme: GoogleFonts.notoSansKrTextTheme(
      TextTheme(
        displayLarge: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(color: primaryTextColor, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: primaryTextColor, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: primaryTextColor, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: primaryTextColor, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: primaryTextColor),
        bodyMedium: TextStyle(color: primaryTextColor),
        bodySmall: TextStyle(color: secondaryTextColor),
        labelLarge: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
        labelMedium: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
        labelSmall: TextStyle(color: secondaryTextColor),
      ),
    ),

    // 앱바 테마
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.notoSansKr(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),

    // 버튼 테마
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        elevation: 2,
      ),
    ),

    // 카드 테마
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // 하단 네비게이션 바 테마
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: secondaryTextColor,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      unselectedLabelStyle: TextStyle(fontSize: 12),
    ),
  );

  // 다크 테마 정의 (필요한 경우)
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.dark(
      primary: primaryLightColor,
      secondary: Color(0xFFA1887F),
      surface: Color(0xFF424242),
      background: Color(0xFF303030),
      error: Color(0xFFEF5350),
    ),
  );
}