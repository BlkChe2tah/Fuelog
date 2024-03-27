import 'package:flutter/material.dart';
import 'package:petrol_ledger/core/design_system/values.dart';
import 'package:petrol_ledger/core/ui/components/export_type_selector.dart';

enum ExportType {
  all,
  date
}

class SaleExportTypeContentLayout extends StatefulWidget {
  final String selectedDate;
  const SaleExportTypeContentLayout({super.key, required this.selectedDate});

  @override
  State<SaleExportTypeContentLayout> createState() => _SaleExportTypeContentLayoutState();
}

class _SaleExportTypeContentLayoutState extends State<SaleExportTypeContentLayout> {
  ExportType _currentExportType = ExportType.date;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: kHuge, vertical: kXLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: colorScheme.surface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Export',
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(
              letterSpacing: 1.2,
              fontSize: 20.0,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: kHuge),
          ExportTypeSelector(
            title: 'Export selected date',
            subtitle: widget.selectedDate,
            isSelected: _currentExportType == ExportType.date,
            onSelectorClicked: () {
              if (_currentExportType != ExportType.date) {
                setState(() {
                  _currentExportType = ExportType.date;
                });
              }
            },
          ),
          const SizedBox(height: kMedium),
          ExportTypeSelector(
            title: 'Export all data',
            subtitle: 'Exporting all data will be delete all record in the database.',
            isSelected: _currentExportType == ExportType.all,
            onSelectorClicked: () {
              if (_currentExportType != ExportType.all) {
                setState(() {
                  _currentExportType = ExportType.all;
                });
              }
            },
          ),
          const SizedBox(height: kXLarge),
          SizedBox(
            height: kButtonSize,
            child: FilledButton(
              onPressed: () {
                Navigator.pop(context, _currentExportType);
              },
              child: Text(
                'Export CSV',
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 1.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
