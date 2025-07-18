import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the wallpaper management application.
/// Implements Contemporary Adaptive Minimalism with Dynamic Content-Aware Palette.
class AppTheme {
  AppTheme._();

  // Dynamic Content-Aware Palette - Colors that adapt to user's selected photos
  // Primary colors
  static const Color primaryLight =
      Color(0xFF6750A4); // Material 3 purple, adapts to dynamic theming
  static const Color primaryDark =
      Color(0xFFD0BCFF); // Light purple for dark theme
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onPrimaryDark = Color(0xFF381E72);

  // Secondary colors
  static const Color secondaryLight =
      Color(0xFF625B71); // Supporting actions and secondary information
  static const Color secondaryDark = Color(0xFFCCC2DC);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryDark = Color(0xFF332D41);

  // Surface colors
  static const Color surfaceLight = Color(
      0xFFFFFBFE); // Clean background that doesn't compete with photo content
  static const Color surfaceDark = Color(0xFF1C1B1F);
  static const Color surfaceVariantLight =
      Color(0xFFE7E0EC); // Subtle container backgrounds for cards
  static const Color surfaceVariantDark = Color(0xFF49454F);
  static const Color onSurfaceLight =
      Color(0xFF1C1B1F); // Primary text color optimized for mobile readability
  static const Color onSurfaceDark = Color(0xFFE6E1E5);
  static const Color onSurfaceVariantLight =
      Color(0xFF49454F); // Secondary text and icons
  static const Color onSurfaceVariantDark = Color(0xFFCAC4D0);

  // Outline colors
  static const Color outlineLight =
      Color(0xFF79747E); // Minimal border usage for input fields
  static const Color outlineDark = Color(0xFF938F99);
  static const Color outlineVariantLight = Color(0xFFCAC4D0);
  static const Color outlineVariantDark = Color(0xFF49454F);

  // Status colors
  static const Color successLight =
      Color(0xFF4CAF50); // Sync status and successful operations
  static const Color successDark = Color(0xFF81C784);
  static const Color warningLight =
      Color(0xFFFF9800); // Permission requests and non-critical alerts
  static const Color warningDark = Color(0xFFFFB74D);
  static const Color errorLight =
      Color(0xFFF44336); // Network failures and critical issues
  static const Color errorDark = Color(0xFFE57373);
  static const Color onErrorLight = Color(0xFFFFFFFF);
  static const Color onErrorDark = Color(0xFF690005);

  // Shadow and scrim colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x1AFFFFFF);
  static const Color scrimLight = Color(0x66000000);
  static const Color scrimDark = Color(0x66000000);

  /// Light theme with Contemporary Adaptive Minimalism
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryLight,
          onPrimary: onPrimaryLight,
          primaryContainer: Color(0xFFEADDFF),
          onPrimaryContainer: Color(0xFF21005D),
          secondary: secondaryLight,
          onSecondary: onSecondaryLight,
          secondaryContainer: Color(0xFFE8DEF8),
          onSecondaryContainer: Color(0xFF1D192B),
          tertiary: Color(0xFF7D5260),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFFFFD8E4),
          onTertiaryContainer: Color(0xFF31111D),
          error: errorLight,
          onError: onErrorLight,
          errorContainer: Color(0xFFFFDAD6),
          onErrorContainer: Color(0xFF410002),
          surface: surfaceLight,
          onSurface: onSurfaceLight,
          surfaceContainerHighest: surfaceVariantLight,
          onSurfaceVariant: onSurfaceVariantLight,
          outline: outlineLight,
          outlineVariant: outlineVariantLight,
          shadow: shadowLight,
          scrim: scrimLight,
          inverseSurface: Color(0xFF313033),
          onInverseSurface: Color(0xFFF4EFF4),
          inversePrimary: primaryDark),
      scaffoldBackgroundColor: surfaceLight,

      // Typography using Roboto for consistent Material Design implementation
      textTheme: _buildTextTheme(isLight: true),

      // AppBar theme - minimal elevation for clean look
      appBarTheme: AppBarTheme(
          backgroundColor: surfaceLight,
          foregroundColor: onSurfaceLight,
          elevation: 0,
          scrolledUnderElevation: 1,
          centerTitle: false,
          titleTextStyle: GoogleFonts.roboto(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: onSurfaceLight)),

      // Card theme - Adaptive Cards with minimal elevation
      cardTheme: CardThemeData( // Corregido: CardThemeData
          color: surfaceLight,
          shadowColor: shadowLight,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

      // Bottom Navigation for contextual navigation
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(elevation: 3),

      // Floating Action Button - Context-aware FAB
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryLight,
          foregroundColor: onPrimaryLight,
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0))),

      // Button themes
      elevatedButtonTheme: const ElevatedButtonThemeData(),
      outlinedButtonTheme: const OutlinedButtonThemeData(),
      textButtonTheme: const TextButtonThemeData(),

      // Input decoration theme - minimal borders, focused states
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceVariantLight,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: primaryLight, width: 2.0)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: errorLight, width: 1.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: errorLight, width: 2.0)),
          labelStyle:
              GoogleFonts.roboto(color: onSurfaceVariantLight, fontSize: 16),
          hintStyle:
              GoogleFonts.roboto(color: onSurfaceVariantLight, fontSize: 16),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16)),

      // Switch theme
      switchTheme: const SwitchThemeData(),

      // Checkbox theme
      checkboxTheme: const CheckboxThemeData(),

      // Radio theme
      radioTheme: const RadioThemeData(),

      // Progress indicator theme - subtle state indicators
      progressIndicatorTheme: const ProgressIndicatorThemeData(),

      // Slider theme
      sliderTheme: const SliderThemeData(),

      // Tab bar theme
      tabBarTheme: TabBarThemeData( // Corregido: TabBarThemeData
          labelColor: primaryLight,
          unselectedLabelColor: onSurfaceVariantLight,
          indicatorColor: primaryLight,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle:
              GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400)),

      // Tooltip theme
      tooltipTheme: const TooltipThemeData(),

      // SnackBar theme
      snackBarTheme: SnackBarThemeData(
          backgroundColor: onSurfaceLight,
          contentTextStyle:
              GoogleFonts.roboto(color: surfaceLight, fontSize: 14),
          actionTextColor: primaryLight,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          elevation: 3),

      // Bottom sheet theme - Contextual Bottom Sheets
      bottomSheetTheme: const BottomSheetThemeData(
          elevation: 8, clipBehavior: Clip.antiAliasWithSaveLayer),

      // Expansion tile theme - Progressive Disclosure
      expansionTileTheme: ExpansionTileThemeData(
          backgroundColor: surfaceLight,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),

      // Divider theme - minimal usage
      dividerTheme: const DividerThemeData());

  /// Dark theme with Contemporary Adaptive Minimalism
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: primaryDark,
          onPrimary: onPrimaryDark,
          primaryContainer: Color(0xFF4F378B),
          onPrimaryContainer: Color(0xFFEADDFF),
          secondary: secondaryDark,
          onSecondary: onSecondaryDark,
          secondaryContainer: Color(0xFF4A4458),
          onSecondaryContainer: Color(0xFFE8DEF8),
          tertiary: Color(0xFFEFB8C8),
          onTertiary: Color(0xFF492532),
          tertiaryContainer: Color(0xFF633B48),
          onTertiaryContainer: Color(0xFFFFD8E4),
          error: errorDark,
          onError: onErrorDark,
          errorContainer: Color(0xFF93000A),
          onErrorContainer: Color(0xFFFFDAD6),
          surface: surfaceDark,
          onSurface: onSurfaceDark,
          surfaceContainerHighest: surfaceVariantDark,
          onSurfaceVariant: onSurfaceVariantDark,
          outline: outlineDark,
          outlineVariant: outlineVariantDark,
          shadow: shadowDark,
          scrim: scrimLight,
          inverseSurface: Color(0xFFE6E1E5),
          onInverseSurface: Color(0xFF313033),
          inversePrimary: primaryLight),
      scaffoldBackgroundColor: surfaceDark,

      // Typography using Roboto for consistent Material Design implementation
      textTheme: _buildTextTheme(isLight: false),

      // AppBar theme - minimal elevation for clean look
      appBarTheme: AppBarTheme(
          backgroundColor: surfaceDark,
          foregroundColor: onSurfaceDark,
          elevation: 0,
          scrolledUnderElevation: 1,
          centerTitle: false,
          titleTextStyle: GoogleFonts.roboto(
              fontSize: 22, fontWeight: FontWeight.w500, color: onSurfaceDark)),

      // Card theme - Adaptive Cards with minimal elevation
      cardTheme: CardThemeData( // Corregido: CardThemeData
          color: Color(0xFF2B2930),
          shadowColor: shadowDark,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

      // Bottom Navigation for contextual navigation
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(elevation: 3),

      // Floating Action Button - Context-aware FAB
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryDark,
          foregroundColor: onPrimaryDark,
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0))),

      // Button themes
      elevatedButtonTheme: const ElevatedButtonThemeData(),
      outlinedButtonTheme: const OutlinedButtonThemeData(),
      textButtonTheme: const TextButtonThemeData(),

      // Input decoration theme - minimal borders, focused states
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceVariantDark,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: primaryDark, width: 2.0)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: errorDark, width: 1.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: errorDark, width: 2.0)),
          labelStyle:
              GoogleFonts.roboto(color: onSurfaceVariantDark, fontSize: 16),
          hintStyle:
              GoogleFonts.roboto(color: onSurfaceVariantDark, fontSize: 16),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16)),

      // Switch theme
      switchTheme: const SwitchThemeData(),

      // Checkbox theme
      checkboxTheme: const CheckboxThemeData(),

      // Radio theme
      radioTheme: const RadioThemeData(),

      // Progress indicator theme - subtle state indicators
      progressIndicatorTheme: const ProgressIndicatorThemeData(),

      // Slider theme
      sliderTheme: const SliderThemeData(),

      // Tab bar theme
      tabBarTheme: TabBarThemeData( // Corregido: TabBarThemeData
          labelColor: primaryDark,
          unselectedLabelColor: onSurfaceVariantDark,
          indicatorColor: primaryDark,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle:
              GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400)),

      // Tooltip theme
      tooltipTheme: const TooltipThemeData(),

      // SnackBar theme
      snackBarTheme: SnackBarThemeData(
          backgroundColor: onSurfaceDark,
          contentTextStyle:
              GoogleFonts.roboto(color: surfaceDark, fontSize: 14),
          actionTextColor: primaryDark,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          elevation: 3),

      // Bottom sheet theme - Contextual Bottom Sheets
      bottomSheetTheme: const BottomSheetThemeData(
          elevation: 8, clipBehavior: Clip.antiAliasWithSaveLayer),

      // Expansion tile theme - Progressive Disclosure
      expansionTileTheme: ExpansionTileThemeData(
          backgroundColor: surfaceDark,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),

      // Divider theme - minimal usage
      dividerTheme: const DividerThemeData());

  /// Helper method to build text theme using Roboto fonts
  /// Implements typography standards for headings, body, captions, and data
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textColor = isLight ? onSurfaceLight : onSurfaceDark;
    final Color textColorVariant =
        isLight ? onSurfaceVariantLight : onSurfaceVariantDark;

    return TextTheme(
        // Display styles - for large headings
        displayLarge: GoogleFonts.roboto(
            fontSize: 57,
            fontWeight: FontWeight.w400,
            color: textColor,
            letterSpacing: -0.25),
        displayMedium: GoogleFonts.roboto(
            fontSize: 45, fontWeight: FontWeight.w400, color: textColor),
        displaySmall: GoogleFonts.roboto(
            fontSize: 36, fontWeight: FontWeight.w400, color: textColor),

        // Headline styles - for section headings
        headlineLarge: GoogleFonts.roboto(
            fontSize: 32,
            fontWeight: FontWeight.w500, // Medium weight for better readability
            color: textColor),
        headlineMedium: GoogleFonts.roboto(
            fontSize: 28, fontWeight: FontWeight.w500, color: textColor),
        headlineSmall: GoogleFonts.roboto(
            fontSize: 24, fontWeight: FontWeight.w500, color: textColor),

        // Title styles - for card titles and important text
        titleLarge: GoogleFonts.roboto(
            fontSize: 22, fontWeight: FontWeight.w500, color: textColor),
        titleMedium: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
            letterSpacing: 0.15),
        titleSmall: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
            letterSpacing: 0.1),

        // Body styles - for main content and album descriptions
        bodyLarge: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w400, // Regular weight for extended reading
            color: textColor,
            letterSpacing: 0.5),
        bodyMedium: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textColor,
            letterSpacing: 0.25),
        bodySmall: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textColorVariant,
            letterSpacing: 0.4),

        // Label styles - for buttons and small UI elements
        labelLarge: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
            letterSpacing: 0.1),
        labelMedium: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textColor,
            letterSpacing: 0.5),
        labelSmall: GoogleFonts.roboto(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textColorVariant,
            letterSpacing: 0.5));
  }

  /// Additional helper methods for status colors
  static Color getSuccessColor(bool isLight) =>
      isLight ? successLight : successDark;
  static Color getWarningColor(bool isLight) =>
      isLight ? warningLight : warningDark;
  static Color getErrorColor(bool isLight) => isLight ? errorLight : errorDark;

  /// Helper method for data/technical text using Roboto Mono
  static TextStyle getDataTextStyle(
      {required bool isLight, double fontSize = 12}) {
    return GoogleFonts.robotoMono(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: isLight ? onSurfaceVariantLight : onSurfaceVariantDark,
        letterSpacing: 0.4);
  }

  /// Helper method for caption text (timestamps, photo counts, metadata)
  static TextStyle getCaptionTextStyle(
      {required bool isLight, double fontSize = 12}) {
    return GoogleFonts.roboto(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: isLight ? onSurfaceVariantLight : onSurfaceVariantDark,
        letterSpacing: 0.4);
  }
}