import 'package:flutter/material.dart';
import 'package:petrol_ledger/provider/sale_price_history_provider.dart';
import 'package:petrol_ledger/repository/sale_price_history/sqlite_sale_price_history.dart';
import 'package:petrol_ledger/screens/sale_price_history/sale_price_history_scrollview.dart';
import 'package:petrol_ledger/utils/ui_state.dart';
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
