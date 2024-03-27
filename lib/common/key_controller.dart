class KeyController {
  static const initialValue = "0";

  String _value = initialValue;
  String get value => _value;

  void reset() {
    _value = initialValue;
  }

  void append(String key, {bool isZeroKey = false}) {
    if (_value == initialValue) {
      if (isZeroKey) return;
      _value = key;
    } else {
      _value = "$_value$key";
    }
  }

  void delete() {
    if (_value == initialValue) return;
    if (_value.length == 1) {
      reset();
    } else {
      _value = _value.substring(0, _value.length - 1);
    }
  }
}
