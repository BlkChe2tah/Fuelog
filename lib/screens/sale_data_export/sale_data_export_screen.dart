import 'package:flutter/material.dart';
import 'package:petrol_ledger/provider/export_data_provider.dart';
import 'package:petrol_ledger/repository/export_data/sqlite_export_data.dart';
import 'package:petrol_ledger/screens/sale_data_export/animated_export_progress.dart';
import 'package:petrol_ledger/screens/sale_data_export/export_selector_layout.dart';
import 'package:petrol_ledger/storage/file_storage.dart';
import 'package:petrol_ledger/utils/extension.dart';
import 'package:petrol_ledger/utils/ui_state.dart';
import 'package:provider/provider.dart';

enum ExportType { all, date }

class SaleDataExportScreen extends StatelessWidget {
  final DateTime date;
  const SaleDataExportScreen({
    super.key,
    required this.date,
  });

  void _showAlertMessage(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.showSnackBar(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExportDataProvider(
        date: date,
        repository: SQLiteExportData(),
        storage: FileStorage(),
      ),
      child: Selector<ExportDataProvider, UiState>(
        selector: (_, provider) => provider.uiState,
        builder: (context, uiState, child) {
          if (uiState is ErrorMode) {
            _showAlertMessage(context, uiState.message);
          }
          if (uiState is LoadingMode) {
            return const AnimatedExportProgress();
          }
          return child!;
        },
        child: const ExportSelectorLayout(),
      ),
    );
  }
}
