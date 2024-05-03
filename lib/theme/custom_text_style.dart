import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body text style
  static get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w400,
      );
// Title text style
  static get titleLarge22 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 22.fSize,
      );
  static get titleLarge23 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 23.fSize,
      );
  static get titleMediumGray700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray700,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumSemiBold => theme.textTheme.titleMedium!.copyWith(
        fontSize: 17.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumSemiBold17 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 17.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmall14 => theme.textTheme.titleSmall!.copyWith(
        fontSize: 14.fSize,
      );
  static get titleSmallRed600 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.red600,
      );
  static get titleSmallYellow90001 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.yellow90001,
      );
}
