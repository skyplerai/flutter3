import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

String _appTheme = "lightCode";
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.gray900,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.black900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 17.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
        ),
        bodyMedium: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 14.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
        ),
        headlineMedium: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 27.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 25.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        labelLarge: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 12.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 20.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 19.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 15.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Black
  Color get black900 => Color(0XFF000000);
// BlueGray
  Color get blueGray400 => Color(0XFF888888);
  Color get blueGray900 => Color(0XFF2D2C2C);
// Gray
  Color get gray600 => Color(0XFF737070);
  Color get gray700 => Color(0XFF686767);
  Color get gray900 => Color(0XFF1E1E1E);
// Red
  Color get red600 => Color(0XFFE63946);
// White
  Color get whiteA700 => Color(0XFFFFFFFF);
// Yellow
  Color get yellow900 => Color(0XFFE69023);
  Color get yellow90001 => Color(0XFFE48914);
  Color get yellow90002 => Color(0XFFE48813);
}
