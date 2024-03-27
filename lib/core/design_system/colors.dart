import 'package:flutter/material.dart';

// Text Color Theme
const Color kPrimaryTextColor = Color(0xFFFFFFFF);
const Color kSecondaryTextColor = Color(0xFF9A9A9A);

// sale price state color
const Color kPriceIncreaseColor = Color(0xFFFA3131);
const Color kPriceDecreaseColor = Color(0xFF8BF576);

// debtor row color
const Color kDebtorRowColor = Color(0xFFB2B37B);

// color
const Color kSurfaceColor = Color(0xFF2D2E41);
const Color kSurfaceLightColor = Color(0xFF3B3C4F);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFFFBA00),
  onPrimary: kPrimaryTextColor,
  // primaryContainer: Color.fromARGB(255, 107, 77, 0),
//   onPrimaryContainer: Color(0xFF6BFF83),
  secondary: Color(0xFF13E9C9),
  onSecondary: kPrimaryTextColor,
  error: Color.fromARGB(255, 202, 9, 9),
  onError: kPrimaryTextColor,
  background: Color(0xFF212433),
  onBackground: kPrimaryTextColor,
  surface: kSurfaceColor,
  onSurface: kPrimaryTextColor,
  surfaceVariant: Color(0xFF323649),
  onSurfaceVariant: kSecondaryTextColor,
  inverseSurface: Color(0xFFA1A6BE),
  onInverseSurface: Color(0xFF212433),
  outline: kPrimaryTextColor,
  outlineVariant: kSecondaryTextColor,
);
