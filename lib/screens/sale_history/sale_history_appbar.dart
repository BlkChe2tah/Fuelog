import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/provider/sale_data_provider.dart';
import 'package:petrol_ledger/provider/sale_history_provider.dart';
import 'package:petrol_ledger/res/values.dart';
import 'package:petrol_ledger/screens/sale_data_export/sale_data_export_screen.dart';
import 'package:petrol_ledger/utils/extension.dart';
import 'package:petrol_ledger/utils/storage_permission.dart';
import 'package:provider/provider.dart';

class SaleHistoryAppbar extends StatelessWidget {
  const SaleHistoryAppbar({
    super.key,
  });

  VoidCallback? _onExportBtnClicked(BuildContext context) {
    return () {
      StoragePermission.checkStoragePermission(
        context,
        onGranted: () async {
          bool? success = await context.showAlertDialog(
            child: SaleDataExportScreen(
              date: context.read<SaleHistoryProvider>().date,
            ),
          );
          if (success != null && success && context.mounted) {
            await context.read<SaleHistoryProvider>().truncateData();
            // ignore: use_build_context_synchronously
            await context.read<SaleDataProvider>().loadLatestSalePrice();
          }
        },
      );
    };
  }

  VoidCallback? _onDateFilterBtnClicked(BuildContext context) {
    return () async {
      var provider = context.read<SaleHistoryProvider>();
      var currentDate = DateTime.now();
      var selectedDate = await showDatePicker(
        context: context,
        initialDate: provider.date,
        firstDate: currentDate.subtract(const Duration(days: 365)),
        lastDate: currentDate,
        keyboardType: TextInputType.datetime,
      );
      if (selectedDate != null) {
        provider.setDate(selectedDate);
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Symbols.arrow_back_ios,
              color: context.loadColorScheme().onSurfaceVariant,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 36.0,
            child: OutlinedButton.icon(
              onPressed: _onDateFilterBtnClicked(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 0.8,
                  color: context.loadColorScheme().onSurfaceVariant,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(kBorderRadius),
                  ),
                ),
              ),
              icon: Icon(
                Symbols.filter_list_rounded,
                color: context.loadColorScheme().primary,
                weight: 500,
              ),
              label: Text(
                context
                    .select<SaleHistoryProvider, DateTime>(
                      (provider) => provider.date,
                    )
                    .formatDMY(),
                style: context.loadTextTheme().labelLarge?.copyWith(
                      fontSize: 16.0,
                      color: context.loadColorScheme().onSurfaceVariant,
                    ),
              ),
            ),
          ),
          const SizedBox(width: kMedium),
          IconButton(
            onPressed: _onExportBtnClicked(context),
            icon: Icon(
              Symbols.upload_file,
              color: context.loadColorScheme().primary,
              weight: 300,
            ),
          ),
          const SizedBox(width: kMedium),
        ],
      ),
    );
  }
}
