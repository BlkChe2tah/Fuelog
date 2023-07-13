import 'package:flutter/foundation.dart';
import 'package:petrol_ledger/repository/sale_data/sale_data_repository.dart';
import 'package:petrol_ledger/core/ui_state.dart';

class SaleDataProvider extends ChangeNotifier {
  UiState _uiState = InitialMode();
  UiState get uiState => _uiState;

  void _setUiState(UiState state) {
    _uiState = state;
    notifyListeners();
  }

  String _salePrice = '0';
  String get salePrice => _salePrice;

  int _salePriceId = 0;
  int get salePriceId => _salePriceId;

  final SaleDataRepository repository;
  SaleDataProvider(this.repository) {
    loadLatestSalePrice();
  }

  Future<void> loadLatestSalePrice() async {
    _setUiState(LoadingMode());
    try {
      var data = await repository.queryLatestSalePrice();
      _salePrice = data.price.toString();
      _salePriceId = data.id!;
      _setUiState(SuccessMode<String>(result: _salePrice));
    } catch (e) {
      _salePrice = '0';
      _salePriceId = 0;
      _setUiState(ErrorMode(message: e.toString()));
    }
  }
}
