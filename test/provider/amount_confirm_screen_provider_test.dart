import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:petrol_ledger/features/amount_collect/amount_confirm_screen_provider.dart';
import 'package:petrol_ledger/repository/sale_data_collect/sale_data_collect_repository.dart';
import 'package:petrol_ledger/core/ui_state.dart';
import 'amount_confirm_screen_provider_test.mocks.dart';

@GenerateMocks([SaleDataCollectRepository])
void main() {
  test('debtor name test', () {
    var provider = AmountConfirmScreenProvider(
      liter: 1,
      amount: 1000,
      salePriceId: 1,
      repository: MockSaleDataCollectRepository(),
    );
    String? name = 'Testing One';
    provider.setDebtorName(name);
    expect(provider.debitorName, name);
  });

  group('data saving', () {
    test('null test on sale price id', () async {
      var mock = MockSaleDataCollectRepository();
      var provider = AmountConfirmScreenProvider(
        liter: 1,
        amount: 1000,
        salePriceId: 0,
        repository: mock,
      );
      final future = provider.save();
      expect(provider.uiState.runtimeType, LoadingMode);
      await future;
      // expect(provider.uiState.runtimeType, ErrorMode);
    });
  });
}
