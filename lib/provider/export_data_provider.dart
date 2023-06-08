import 'package:flutter/foundation.dart';
import 'package:petrol_ledger/model/sale_item_data.dart';
import 'package:petrol_ledger/repository/export_data/export_data_repository.dart';
import 'package:petrol_ledger/screens/sale_data_export/sale_data_export_screen.dart';
import 'package:petrol_ledger/storage/sale_data_storage.dart';
import 'package:petrol_ledger/utils/csv_formatter.dart';
import 'package:petrol_ledger/utils/extension.dart';
import 'package:petrol_ledger/utils/ui_state.dart';

class ExportDataProvider extends ChangeNotifier {
  final ExportDataRepository repository;
  final SaleDataStorage storage;
  final DateTime date;
  ExportDataProvider({
    required this.repository,
    required this.storage,
    required this.date,
  });

  int _progress = 0;
  int get progress => _progress;
  void _setProgress(int progress) {
    _progress = progress;
    notifyListeners();
  }

  void _resetProgress() {
    _progress = 0;
    notifyListeners();
  }

  UiState _uiState = InitialMode();
  UiState get uiState => _uiState;
  void _setUiState(UiState state) {
    _uiState = state;
    notifyListeners();
  }

  UiState _exportState = InitialMode();
  UiState get exportState => _exportState;
  void _setExportState(UiState state) {
    _exportState = state;
    notifyListeners();
  }

  ExportType _exportType = ExportType.date;
  ExportType get exportType => _exportType;

  void setExportType(ExportType type) {
    if (type == _exportType) return;
    _exportType = type;
    notifyListeners();
  }

  void export() async {
    _setUiState(LoadingMode());
    try {
      final int count = await _loadRecordCount();
      if (count == 0) {
        _setUiState(ErrorMode(message: _loadEmptyMessage()));
        return;
      }
      _exportData(count);
    } catch (e) {
      _setUiState(ErrorMode(message: e.toString()));
    }
  }

  void _exportData(int count) {
    _setExportState(ExportingMode());
    try {
      final data = _loadExportData();
      _resetProgress();
      _generateCSVFileWithProgress(
        data,
        count,
        onSuccess: () => _setExportState(ExportingSuccessMode()),
      );
    } catch (e) {
      _setExportState(ExportingErrorMode());
    }
  }

  void _generateCSVFileWithProgress(Stream<SaleItemData> data, int count,
      {VoidCallback? onSuccess}) async {
    try {
      double currentCount = 0;
      final formatter = CSVFormatter(separator: ',');
      final fName = "${DateTime.now().formatFileName()}-fuelog.csv";
      await storage.create(fileName: fName);
      storage.write(formatter.generateHeader());
      await for (final item in data) {
        storage.write(formatter.formatRow(item));
        _updateProgress(++currentCount, count);
      }
      onSuccess?.call();
    } catch (e) {
      throw Exception('Unexcepted error occur when generating the CSV File.');
    } finally {
      storage.close();
    }
  }

  void _updateProgress(double currentCount, int count) {
    final percent = (currentCount / count) * 100;
    _setProgress(percent.round());
  }

  Stream<SaleItemData> _loadExportData() {
    return _exportType == ExportType.all
        ? repository.queryAllDataAsStream()
        : repository.queryDataByDateAsStream(date);
  }

  Future<int> _loadRecordCount() {
    if (_exportType == ExportType.all) {
      return repository.loadAllItemCount();
    } else {
      return repository.loadItemCountByDate(date);
    }
  }

  String _loadEmptyMessage() {
    if (_exportType == ExportType.all) {
      return 'Cannot export data because data is empty.';
    } else {
      return 'Cannot export data on this day because data is empty.';
    }
  }
}

extension _CSVFormat on CSVFormatter {
  String generateHeader() {
    addElement('Date');
    addElement('Amount');
    addElement('Liter');
    addElement('Sale Price');
    addElement('Name');
    return format();
  }

  String formatRow(SaleItemData data) {
    addElement(data.date.formatDMY());
    addElement(data.amount.toString());
    addElement(data.liter.toStringAsFixed(3));
    addElement(data.salePrice.toString());
    addElement(data.name);
    return format();
  }
}
