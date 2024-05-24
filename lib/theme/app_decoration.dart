import 'package:flutter/material.dart';

import '../core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );

  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );

  static BoxDecoration get fillPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.primaryContainer,
      );

  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );

  // Fill decorations
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray900,
      );

  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray900,
      );

// Outline decorations
  static BoxDecoration get outlineWhiteA => BoxDecoration(
        color: appTheme.gray900,
        border: Border.all(
          color: appTheme.whiteA700,
          width: 1.h,
        ),
      );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get circleBorder163 => BorderRadius.circular(
        163.h,
      );

  static BorderRadius get roundedBorder25 => BorderRadius.circular(
        25.h,
      );

// Rounded borders
  static BorderRadius get roundedBorder168 => BorderRadius.circular(
        168.h,
      );

  static BorderRadius get roundedBorder14 => BorderRadius.circular(
        14.h,
      );

  static BorderRadius get roundedBorder18 => BorderRadius.circular(
        18.h,
      );

  static BorderRadius get roundedBorder27 => BorderRadius.circular(
        27.h,
      );

  static BorderRadius get roundedBorder39 => BorderRadius.circular(
        39.h,
      );
}
