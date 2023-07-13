import 'package:flutter/material.dart';
import 'package:petrol_ledger/model/sale_price.dart';
import 'package:petrol_ledger/repository/sale_price_collect/sale_price_collect_repository.dart';
import 'package:petrol_ledger/features/collect/view/sale_price_collect_screen.dart';
import 'package:petrol_ledger/core/ui_state.dart';

class SalePriceCollectProvider extends ChangeNotifier {
  UiState _uiState = InitialMode();
  UiState get uiState => _uiState;
  void _setUiState(UiState state) {
    _uiState = state;
    notifyListeners();
  }

  double _salePrice = SalePriceCollectScreen.minAmount;
  double get salePrice => _salePrice;

  final SalePriceCollectRepository repository;
  SalePriceCollectProvider({required this.repository});

  void increaseSalePricebyOne() {
    if (_salePrice < SalePriceCollectScreen.maxAmount) {
      setSalePrice(_salePrice + 1);
    }
  }

  void decreaseSalePricebyOne() {
    if (_salePrice > SalePriceCollectScreen.minAmount) {
      setSalePrice(_salePrice - 1);
    }
  }

  void setSalePrice(double price) {
    _salePrice = price.ceilToDouble();
    notifyListeners();
  }

  void save() async {
    _setUiState(LoadingMode());
    try {
      var data = SalePrice(
        price: _salePrice.toInt(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      await repository.addSalePrice(data);
      _setUiState(SuccessMode(result: 'Success'));
    } catch (e) {
      _setUiState(ErrorMode(message: e.toString()));
    }
  }
}
