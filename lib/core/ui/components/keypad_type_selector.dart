import 'package:flutter/material.dart';
import 'package:petrol_ledger/core/design_system/values.dart';

enum KeypadType {
  amount,
  liter
}

class KeypadTypeSelector extends StatelessWidget {
  final KeypadType selectedType;
  final void Function(KeypadType) onKeypadTypeChanged;
  const KeypadTypeSelector({super.key, required this.selectedType, required this.onKeypadTypeChanged});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SegmentedButton<KeypadType>(
      selected: {
        selectedType
      },
      showSelectedIcon: false,
      segments: const <ButtonSegment<KeypadType>>[
        ButtonSegment<KeypadType>(value: KeypadType.amount, label: Text('AMOUNT')),
        ButtonSegment<KeypadType>(value: KeypadType.liter, label: Text('LITER')),
      ],
      onSelectionChanged: (onSelected) {
        onKeypadTypeChanged(onSelected.last);
      },
      style: SegmentedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: kXLarge),
        side: BorderSide(color: colorScheme.surfaceVariant),
        foregroundColor: colorScheme.onSurfaceVariant,
        selectedForegroundColor: colorScheme.primary,
        backgroundColor: colorScheme.background,
        selectedBackgroundColor: colorScheme.background,
      ),
    );
  }
}
