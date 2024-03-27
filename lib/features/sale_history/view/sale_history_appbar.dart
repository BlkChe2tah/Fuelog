import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/core/design_system/values.dart';
import 'package:petrol_ledger/core/ui/sale_export_type_content_layout.dart';
import 'package:petrol_ledger/features/sale_history/bloc/sale_history_bloc.dart';

class SaleHistoryAppbar extends StatelessWidget {
  const SaleHistoryAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      backgroundColor: colorScheme.background,
      scrolledUnderElevation: 0,
      actions: [
        OutlinedButton.icon(
          onPressed: () async {
            final currentDate = context.read<SaleHistoryBloc>().state.currentSelectedDate;
            final result = await _showDatePickerDialog(context, currentDate);
            if (result != null && context.mounted) {
              context.read<SaleHistoryBloc>().add(LoadAllSalesRecordByDate(result));
            }
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              width: 0.8,
              color: colorScheme.onSurfaceVariant,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kBorderRadius),
              ),
            ),
          ),
          icon: Icon(
            Symbols.filter_list_rounded,
            color: colorScheme.primary,
            weight: 500,
          ),
          label: Text(
            context.select<SaleHistoryBloc, String>((bloc) => bloc.state.date),
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        IconButton(
          onPressed: context.select<SaleHistoryBloc, bool>((bloc) => bloc.isEmptyRecord)
              ? null
              : () async {
                  final result = await _showSaleExportTypeSelectDialog(context);
                  if (result != null && context.mounted) {
                    // if (result == ExportType.date) {
                    //   final recordCount = context.read<SaleHistoryBloc>().state.recordCountByDate;
                    //   if (recordCount == 0) {
                    //     context.showSnackBar("Sale records cannot be exported for the current selected date. Because the record is empty");
                    //     return;
                    //   }
                    // }
                    // context.read<SaleHistoryBloc>().add(ExportSaleRecord(result));
                  }
                },
          icon: Icon(
            Symbols.upload_file,
            color: context.select<SaleHistoryBloc, bool>((bloc) => bloc.isEmptyRecord) ? colorScheme.primary.withAlpha(100) : colorScheme.primary,
            weight: 300,
          ),
        ),
      ],
    );
  }

  Future<ExportType?> _showSaleExportTypeSelectDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          final selectedDate = context.read<SaleHistoryBloc>().state.currentSelectedDate;
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.symmetric(horizontal: kLarge, vertical: kHuge),
            content: SaleExportTypeContentLayout(selectedDate: DateFormat.yMMMMd().format(selectedDate)),
          );
        });
  }

  Future<DateTime?> _showDatePickerDialog(BuildContext context, DateTime currentSelectedDate) {
    return showDatePicker(
      context: context,
      initialDate: currentSelectedDate,
      firstDate: currentSelectedDate.subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      keyboardType: TextInputType.datetime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  surfaceTint: Colors.transparent,
                ),
          ),
          child: child!,
        );
      },
    );
  }
}
