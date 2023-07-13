import 'package:flutter/material.dart';
import 'package:petrol_ledger/features/collect/domain/sale_price_collect_provider.dart';
import 'package:petrol_ledger/repository/sale_price_collect/sqlite_sale_price_collect.dart';
import 'package:petrol_ledger/features/collect/view/sale_price_collect_container.dart';
import 'package:petrol_ledger/core/utils/extension.dart';
import 'package:petrol_ledger/core/ui_state.dart';
import 'package:provider/provider.dart';

class SalePriceCollectScreen extends StatelessWidget {
  static const double minAmount = 200;
  static const double maxAmount = 5000;
  final bool showInfoView;

  const SalePriceCollectScreen({super.key, this.showInfoView = false});

  void _showAlertMessage(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.showSnackBar(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SalePriceCollectProvider(
        repository: SQLiteSalePriceCollect(),
      ),
      child: Selector<SalePriceCollectProvider, UiState>(
        selector: (_, provider) => provider.uiState,
        builder: (context, uiState, child) {
          if (uiState is ErrorMode) {
            _showAlertMessage(context, uiState.message);
          }
          if (uiState is SuccessMode) {
            _showAlertMessage(
                context, 'The sale price was successfully updated');
            Navigator.pop(context, true);
          }
          return child!;
        },
        child: Provider<bool>(
          create: (context) => showInfoView,
          child: const SalePriceCollectContainer(),
        ),
      ),
    );
  }
}
