import 'package:flutter/material.dart';
import 'package:petrol_ledger/component/close_btn.dart';
import 'package:petrol_ledger/provider/export_data_provider.dart';
import 'package:petrol_ledger/res/values.dart';
import 'package:petrol_ledger/screens/sale_data_export/export_type_selector.dart';
import 'package:petrol_ledger/screens/sale_data_export/sale_data_export_screen.dart';
import 'package:petrol_ledger/utils/extension.dart';
import 'package:provider/provider.dart';

class ExportSelectorLayout extends StatelessWidget {
  const ExportSelectorLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: context.loadColorScheme().surface,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHuge,
              vertical: kXLarge,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Export',
                  textAlign: TextAlign.center,
                  style: context.loadTextTheme().headlineSmall?.copyWith(
                        letterSpacing: 1.2,
                        fontSize: 20.0,
                        color: context.loadColorScheme().onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: kHuge),
                Selector<ExportDataProvider, ExportType>(
                  selector: (_, provider) => provider.exportType,
                  builder: (context, type, _) {
                    return Column(
                      children: [
                        ExportTypeSelector(
                          title: 'Export selected date',
                          subtitle: context
                              .read<ExportDataProvider>()
                              .date
                              .formatDMY(),
                          isSelected: type == ExportType.date,
                          onSelectorClicked: () {
                            context
                                .read<ExportDataProvider>()
                                .setExportType(ExportType.date);
                          },
                        ),
                        const SizedBox(height: kMedium),
                        ExportTypeSelector(
                          title: 'Export all data',
                          subtitle:
                              'Exporting all data will be delete all record in the database.',
                          isSelected: type == ExportType.all,
                          onSelectorClicked: () {
                            context
                                .read<ExportDataProvider>()
                                .setExportType(ExportType.all);
                          },
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: kXLarge),
                SizedBox(
                  height: kButtonSize,
                  child: FilledButton(
                    onPressed: () {
                      context.read<ExportDataProvider>().export();
                    },
                    child: Text(
                      'Export CSV',
                      style: context.loadTextTheme().labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            letterSpacing: 1.8,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 0.0,
            right: 0.0,
            child: CloseBtn(),
          ),
        ],
      ),
    );
  }
}
