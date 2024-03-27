import 'package:intl/intl.dart';

abstract class AppPriceFormatter {
  String format(double price);
}

final class MMKPriceWithSymbolFormatter implements AppPriceFormatter {
  static final _numberFormat = NumberFormat.decimalPattern();

  @override
  String format(double price) {
    return "${_numberFormat.format(price)} Ks";
  }
}

final class MMKPriceFormatter implements AppPriceFormatter {
  static final _numberFormat = NumberFormat.decimalPattern();

  @override
  String format(double price) {
    return _numberFormat.format(price);
  }
}
