import 'package:flutter/material.dart';
import 'package:petrol_ledger/features/history/domain/sale_history_provider.dart';
import 'package:petrol_ledger/features/history/view/sale_history_appbar.dart';
import 'package:petrol_ledger/features/history/view/sale_history_list.dart';
import 'package:petrol_ledger/repository/sale_history/sqlite_sale_history.dart';
import 'package:petrol_ledger/core/ui_state.dart';
import 'package:provider/provider.dart';

class SaleHistoryScreen extends StatelessWidget {
  const SaleHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => SaleHistoryProvider(repository: SQLiteSaleHistory()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SaleHistoryAppbar(),
              Expanded(
                child: Selector<SaleHistoryProvider, UiState>(
                  selector: (_, provider) => provider.uiState,
                  builder: (context, uiState, child) {
                    if (uiState is LoadingMode) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (uiState is EmptyMode) {
                      return const Center(
                        child: Text('No Data'),
                      );
                    } else if (uiState is ErrorMode) {
                      return Center(
                        child: Text(uiState.message),
                      );
                    } else {
                      return child!;
                    }
                  },
                  child: const SaleHistoryList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
