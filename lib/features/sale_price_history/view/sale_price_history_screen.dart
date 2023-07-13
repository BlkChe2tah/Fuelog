import 'package:flutter/material.dart';
import 'package:petrol_ledger/features/sale_price_update/domain/sale_price_history_provider.dart';
import 'package:petrol_ledger/features/sale_price_history/data/repository/sqlite_sale_price_history.dart';
import 'package:petrol_ledger/features/sale_price_history/view/sale_price_history_scrollview.dart';
import 'package:petrol_ledger/core/ui_state.dart';
import 'package:provider/provider.dart';

class SalePriceHistoryScreen extends StatelessWidget {
  const SalePriceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SalePriceHistoryProvider(
        repository: SQLiteSalePriceHistory(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Selector<SalePriceHistoryProvider, UiState>(
          selector: (_, provider) => provider.uiState,
          builder: (context, state, child) {
            if (state is LoadingMode) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return child!;
          },
          child: const SalePriceHistoryScrollView(),
        ),
      ),
    );
  }
}
