import 'package:flutter/foundation.dart';
import 'package:petrol_ledger/screens/keypad/keypad_type_selector.dart';
import 'package:petrol_ledger/utils/keys.dart';

class KeypadScreenProvider extends ChangeNotifier {
  static const initValue = '0';
  static const defaultKeypadType = KeypadType.amount;

  String _amount = initValue;
  String get amount => _amount;

  String _liter = initValue;
  String get liter => _liter;

  KeypadType _keypadType = KeypadType.amount;
  KeypadType get keypadType => _keypadType;

  final KeypadController _amountController = KeypadController(initValue);
  final KeypadController _literController = KeypadController(initValue);

  void setKeypadType(KeypadType type) {
    if (type == _keypadType) return;
    _keypadType = type;
    reset();
  }

  void reset() {
    _amount = initValue;
    _liter = initValue;
    _amountController.reset();
    _literController.reset();
    notifyListeners();
  }

  void emit({
    required int salePrice,
    required Keys key,
    String? value,
  }) {
    // Amount Keypad type
    if (_keypadType == KeypadType.amount) {
      String temp = _amountController.submit(key, value);
      if (temp == _amount) return;
      _amount = temp;
      var length = _amount == initValue ? 0 : 3;
      _liter = (int.parse(_amount) / salePrice).toStringAsFixed(length);
    }
    // Liter Keypad type
    if (_keypadType == KeypadType.liter) {
      String temp = _literController.submit(key, value);
      if (temp == _liter) return;
      _liter = temp;
      _amount = (double.parse(_liter) * salePrice).ceil().toString();
    }
    notifyListeners();
  }
}

class KeypadController {
  final String _initValue;

  String _value;
  String get value => _value;

  KeypadController(this._value) : _initValue = _value;

  String submit(Keys key, String? keyValue) {
    switch (key) {
      case Keys.numbers:
        return _append(keyValue: keyValue);
      case Keys.delete:
        return _delete();
    }
  }

  void reset() {
    _value = _initValue;
  }

  String _append({String? keyValue}) {
    if (keyValue == null) {
      throw Exception('Undefined keyValue value');
    }
    bool isZerokeyValue = keyValue == '0' || keyValue == '00';
    if (_value.length == 1 && _value == _initValue) {
      if (isZerokeyValue) return _initValue;
      if (keyValue == '.') return _value = '$value$keyValue';
      _value = keyValue;
    } else {
      _value = '$value$keyValue';
    }
    return _value;
  }

  String _delete() {
    bool isStart = _value.length == 1;
    if (isStart) {
      if (_value == _initValue) return _initValue;
      _value = '0';
    } else {
      _value = _value.substring(0, _value.length - 1);
    }
    return _value;
  }
}
