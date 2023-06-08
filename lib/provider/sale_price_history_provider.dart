import 'package:flutter/material.dart';
import 'package:petrol_ledger/model/sale_price_item_data.dart';
import 'package:petrol_ledger/repository/sale_price_history/sale_price_history_repository.dart';
import 'package:petrol_ledger/utils/ui_state.dart';

class SalePriceHistoryProvider extends ChangeNotifier {
  UiState _uiState = InitialMode();
  UiState get uiState => _uiState;
  void _setUiState(UiState state) {
    _uiState = state;
    notifyListeners();
  }

  final SalePriceHistoryRepository repository;

  SalePriceHistoryProvider({required this.repository}) {
    loadSalePrices();
  }

  void loadSalePrices() async {
    _setUiState(LoadingMode());
    try {
      var data = await repository.loadSalePrices();
      if (data.isEmpty) {
        _setUiState(EmptyMode());
      } else {
        _setUiState(SuccessMode<List<SalePriceItemData>>(result: data));
      }
    } catch (e) {
      _setUiState(ErrorMode(message: e.toString()));
    }
  }
}
