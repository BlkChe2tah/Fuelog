import 'package:flutter/foundation.dart';
import 'package:petrol_ledger/model/sale_item_data.dart';
import 'package:petrol_ledger/repository/sale_history/sale_history_repository.dart';
import 'package:petrol_ledger/core/utils/extension.dart';
import 'package:petrol_ledger/core/ui_state.dart';

class SaleHistoryProvider extends ChangeNotifier {
  UiState _uiState = InitialMode();
  UiState get uiState => _uiState;
  void _setUiState(UiState state) {
    _uiState = state;
    notifyListeners();
  }

  DateTime _date = DateTime.now().convertDMY();
  DateTime get date => _date;

  void setDate(DateTime pickerDate) {
    if (pickerDate != _date) {
      _date = pickerDate;
      notifyListeners();
      loadSales();
    }
  }

  final SaleHistoryRepository repository;

  SaleHistoryProvider({required this.repository}) {
    loadSales();
  }

  void loadSales() async {
    _setUiState(LoadingMode());
    try {
      var data = await repository.loadSaleDataByDate(_date);
      if (data.isEmpty) {
        _setUiState(EmptyMode());
      } else {
        _setUiState(SuccessMode<List<SaleItemData>>(result: data));
      }
    } catch (e) {
      _setUiState(ErrorMode(message: e.toString()));
    }
  }

  Future<void> truncateData() async {
    try {
      _setUiState(LoadingMode());
      await repository.deleteAllData();
      _setUiState(EmptyMode());
    } catch (e) {
      _setUiState(ErrorMode(message: e.toString()));
    }
  }
}
