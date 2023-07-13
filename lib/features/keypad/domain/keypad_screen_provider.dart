import 'package:flutter/foundation.dart';
import 'package:petrol_ledger/features/keypad/views/widgets/keypad_type_selector.dart';
import 'package:petrol_ledger/core/keys.dart';

class KeypadScreenProvider extends ChangeNotifier {
  static const initValue = '0';
  static const defaultKeypadType = KeypadType.amount;

  @visibleForTesting
  String prvAmount = initValue;
  String get amount => prvAmount;

  @visibleForTesting
  String prvLiter = initValue;
  String get liter => prvLiter;

  @visibleForTesting
  KeypadType prvKeypadType = defaultKeypadType;
  KeypadType get keypadType => prvKeypadType;

  @visibleForTesting
  final KeypadController amountController = KeypadController(initValue);
  @visibleForTesting
  final KeypadController literController = KeypadController(initValue);

  void setKeypadType(KeypadType type) {
    if (type == prvKeypadType) return;
    prvKeypadType = type;
    reset();
  }

  void reset() {
    prvAmount = initValue;
    prvLiter = initValue;
    amountController.reset();
    literController.reset();
    notifyListeners();
  }

  void emit({
    required int salePrice,
    required Keys key,
    String? value,
  }) {
    // Amount Keypad type
    if (prvKeypadType == KeypadType.amount) {
      String temp = amountController.submit(key, value);
      if (temp == prvAmount) return;
      prvAmount = temp;
      var length = prvAmount == initValue ? 0 : 3;
      prvLiter = (int.parse(prvAmount) / salePrice).toStringAsFixed(length);
    }
    // Liter Keypad type
    if (prvKeypadType == KeypadType.liter) {
      String temp = literController.submit(key, value);
      if (temp == prvLiter) return;
      prvLiter = temp;
      prvAmount = (double.parse(prvLiter) * salePrice).ceil().toString();
    }
    notifyListeners();
  }
}

// Keypad Controller
@visibleForTesting
class KeypadController {
  final String _initValue;

  @visibleForTesting
  String prvValue;
  String get value => prvValue;

  KeypadController(this.prvValue) : _initValue = prvValue;

  String submit(Keys key, String? keyValue) {
    switch (key) {
      case Keys.numbers:
        return _append(keyValue: keyValue);
      case Keys.delete:
        return _delete();
    }
  }

  void reset() {
    prvValue = _initValue;
  }

  String _append({String? keyValue}) {
    if (keyValue == null) {
      throw Exception('Undefined keyValue value');
    }
    bool isZerokeyValue = keyValue == '0' || keyValue == '00';
    if (prvValue.length == 1 && prvValue == _initValue) {
      if (isZerokeyValue) return _initValue;
      if (keyValue == '.') return prvValue = '$value$keyValue';
      prvValue = keyValue;
    } else {
      prvValue = '$value$keyValue';
    }
    return prvValue;
  }

  String _delete() {
    bool isStart = prvValue.length == 1;
    if (isStart) {
      if (prvValue == _initValue) return _initValue;
      prvValue = '0';
    } else {
      prvValue = prvValue.substring(0, prvValue.length - 1);
    }
    return prvValue;
  }
}
