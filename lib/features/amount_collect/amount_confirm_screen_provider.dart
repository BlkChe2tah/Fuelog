import 'package:flutter/foundation.dart';
import 'package:petrol_ledger/model/sale.dart';
import 'package:petrol_ledger/repository/sale_data_collect/sale_data_collect_repository.dart';
import 'package:petrol_ledger/core/ui_state.dart';

class AmountConfirmScreenProvider extends ChangeNotifier {
  UiState _uiState = InitialMode();
  UiState get uiState => _uiState;
  void _setUiState(UiState state) {
    _uiState = state;
    notifyListeners();
  }

  String? _debitorName;
  String? get debitorName => _debitorName;

  final int amount;
  final double liter;
  final int salePriceId;
  final SaleDataCollectRepository repository;

  AmountConfirmScreenProvider({
    required this.liter,
    required this.amount,
    required this.salePriceId,
    required this.repository,
  });

  void setDebtorName(String name) {
    _debitorName = name;
    notifyListeners();
  }

  Future<void> save() async {
    _setUiState(LoadingMode());
    if (salePriceId == 0) {
      _setUiState(ErrorMode(message: "Oops! Sale price can't be zero."));
      return;
    }
    if (_debitorName != null) {
      RegExp exp =
          RegExp(r'[\d\u0021-\u002F\u003A-\u0040\u005B-\u0060\u007B-\u007E]');
      if (exp.hasMatch(_debitorName!)) {
        _setUiState(ErrorMode(
            message:
                'Debtor name cannot contain numbers and special characters.'));
        return;
      }
    }
    try {
      var data = Sale(
        name: _debitorName,
        amount: amount,
        salePriceId: salePriceId,
        liter: liter,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      await repository.insert(data);
      _setUiState(SuccessMode(result: 'Success'));
    } catch (e) {
      _setUiState(ErrorMode(message: e.toString()));
    }
  }
}
