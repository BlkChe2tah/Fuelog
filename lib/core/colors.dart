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

// const darkColorScheme = ColorScheme(
//   brightness: Brightness.dark,
//   primary: Color(0xFF00E55B),
//   onPrimary: Color(0xFF003910),
//   primaryContainer: Color(0xFF00531B),
//   onPrimaryContainer: Color(0xFF6BFF83),
//   secondary: Color(0xFFB9CCB5),
//   onSecondary: Color(0xFF243424),
//   secondaryContainer: Color(0xFF3A4B39),
//   onSecondaryContainer: Color(0xFFD4E8D0),
//   tertiary: Color(0xFFA1CED6),
//   onTertiary: Color(0xFF00363C),
//   tertiaryContainer: Color(0xFF1F4D53),
//   onTertiaryContainer: Color(0xFFBCEBF2),
//   error: Color(0xFFFFB4AB),
//   errorContainer: Color(0xFF93000A),
//   onError: Color(0xFF690005),
//   onErrorContainer: Color(0xFFFFDAD6),
//   background: Color(0xFF1A1C19),
//   onBackground: Color(0xFFE2E3DD),
//   surface: Color(0xFF1A1C19),
//   onSurface: Color(0xFFE2E3DD),
//   surfaceVariant: Color(0xFF424940),
//   onSurfaceVariant: Color(0xFFC2C9BD),
//   outline: Color(0xFF8C9389),
//   onInverseSurface: Color(0xFF1A1C19),
//   inverseSurface: Color(0xFFE2E3DD),
//   inversePrimary: Color(0xFF006E27),
//   shadow: Color(0xFF000000),
//   surfaceTint: Color(0xFF00E55B),
//   outlineVariant: Color(0xFF424940),
//   scrim: Color(0xFF000000),
// );




// colors: [
//   Color.fromARGB(255, 252, 238, 238),
//   Color.fromARGB(255, 244, 228, 228),
// ],
// theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      // darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),