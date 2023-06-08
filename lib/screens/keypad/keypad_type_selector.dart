import 'package:flutter/material.dart';
import 'package:petrol_ledger/res/values.dart';
import 'package:petrol_ledger/utils/extension.dart';

enum KeypadType { amount, liter }

typedef KeypadTypeSelectorChanged = void Function(Set<KeypadType>);

class KeypadTypeSelector extends StatefulWidget {
  final KeypadTypeSelectorChanged? onChanged;
  const KeypadTypeSelector({super.key, this.onChanged});

  @override
  State<KeypadTypeSelector> createState() => _KeypadTypeSelectorState();
}

class _KeypadTypeSelectorState extends State<KeypadTypeSelector> {
  Set<KeypadType> _selected = {KeypadType.amount};
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<KeypadType>(
      selected: _selected,
      showSelectedIcon: false,
      segments: const <ButtonSegment<KeypadType>>[
        ButtonSegment<KeypadType>(
            value: KeypadType.amount, label: Text('AMOUNT')),
        ButtonSegment<KeypadType>(
            value: KeypadType.liter, label: Text('LITER')),
      ],
      onSelectionChanged: (onSelected) {
        setState(() {
          _selected = onSelected;
        });
        widget.onChanged?.call(onSelected);
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith((states) {
          return const EdgeInsets.symmetric(horizontal: kXLarge);
        }),
        side: MaterialStateProperty.resolveWith<BorderSide?>((states) {
          return BorderSide(color: context.loadColorScheme().surfaceVariant);
        }),
        foregroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return context.loadColorScheme().primary;
          }
          return context.loadColorScheme().onSurfaceVariant;
        }),
        backgroundColor: MaterialStateColor.resolveWith((states) {
          return context.loadColorScheme().background;
        }),
      ),
    );
  }
}
