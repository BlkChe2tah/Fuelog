import 'package:intl/intl.dart';

abstract class AppDateFormatter {
  String format(DateTime date);
}

final class MMMMDFormatter implements AppDateFormatter {
  static final _format = DateFormat.MMMMd();

  @override
  String format(DateTime date) {
    return _format.format(date);
  }
}

final class YMMMMDFormatter implements AppDateFormatter {
  static final _format = DateFormat.yMMMMd();

  @override
  String format(DateTime date) {
    return _format.format(date);
  }
}

final class HmFormatter implements AppDateFormatter {
  static final _format = DateFormat(DateFormat.HOUR_MINUTE_TZ);

  @override
  String format(DateTime date) {
    return _format.format(date);
  }
}
