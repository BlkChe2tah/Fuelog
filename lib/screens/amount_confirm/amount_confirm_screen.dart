import 'package:flutter/material.dart';
import 'package:petrol_ledger/provider/amount_confirm_screen_provider.dart';
import 'package:petrol_ledger/provider/sale_data_provider.dart';
import 'package:petrol_ledger/repository/sale_data_collect/sqlite_sale_data_collect.dart';
import 'package:petrol_ledger/screens/amount_confirm/amount_confrim_container.dart';
import 'package:petrol_ledger/utils/extension.dart';
import 'package:petrol_ledger/utils/ui_state.dart';
import 'package:provider/provider.dart';

class AmountConfirmScreen extends StatelessWidget {
  final double saleLiter;
  final int saleAmount;
  const AmountConfirmScreen({
    super.key,
    required this.saleLiter,
    required this.saleAmount,
  });

  void _showAlertMessage(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.showSnackBar(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AmountConfirmScreenProvider(
        liter: saleLiter,
        amount: saleAmount,
        salePriceId: context.read<SaleDataProvider>().salePriceId,
        repository: SQLiteSaleDataCollect(),
      ),
      child: Selector<AmountConfirmScreenProvider, UiState>(
        selector: (_, provider) => provider.uiState,
        builder: (context, uiState, child) {
          if (uiState is ErrorMode) {
            _showAlertMessage(context, uiState.message);
          }
          if (uiState is SuccessMode) {
            _showAlertMessage(context, 'The record was saved successfully.');
            Navigator.pop(context, true);
          }
          return child!;
        },
        child: const AmountConfirmContainer(),
      ),
    );
  }
}
