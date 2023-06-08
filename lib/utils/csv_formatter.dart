class CSVFormatter {
  final String separator;
  final List<String> _data = [];
  CSVFormatter({required this.separator});

  void addElement(String value) {
    _data.add(value);
  }

  String format() {
    if (_data.isEmpty) {
      throw Exception('Data cannot convert to the CSV format.');
    }
    final temp = _data.join(separator);
    _data.clear();
    return temp;
  }
}
