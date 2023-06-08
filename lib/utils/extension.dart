import 'package:flutter/material.dart';
import 'package:petrol_ledger/res/values.dart';

extension AppTheme on BuildContext {
  ColorScheme loadColorScheme() {
    return Theme.of(this).colorScheme;
  }

  TextTheme loadTextTheme() {
    return Theme.of(this).textTheme;
  }
}

extension DateUtil on DateTime {
  DateTime convertDMY() {
    return DateTime(year, month, day);
  }

  String formatFileName() {
    final tempM = '${month > 9 ? month : '0$month'}';
    final tempD = '${day > 9 ? day : '0$day'}';
    final tempH = '${hour > 9 ? hour : '0$hour'}';
    final tempMin = '${minute > 9 ? minute : '0$minute'}';
    final tempSec = '${second > 9 ? second : '0$second'}';
    return '$year$tempM$tempD$tempH$tempMin$tempSec';
  }

  String formatDMY() {
    return '$day/$month/$year';
  }

  DateTime getDateLimit() {
    return add(const Duration(days: 1));
  }
}

extension ShowDialog on BuildContext {
  Future<T?> showAlertDialog<T>({required Widget child}) {
    return showDialog(
      context: this,
      barrierColor: Colors.black54,
      barrierDismissible: false,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              contentPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.all(kLarge),
              content: child,
            ),
          ),
        );
      },
    );
  }
}

extension ShowSnackBar on BuildContext {
  void showSnackBar(String message) {
    var colorScheme = Theme.of(this).colorScheme;
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(this).textTheme.labelLarge?.copyWith(
                color: colorScheme.onInverseSurface,
                fontSize: 16.0,
              ),
        ),
        backgroundColor: colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
      ),
    );
  }
}
