import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/core/ui/components/input_key.dart';
import 'package:petrol_ledger/core/ui/components/keypad_type_selector.dart';

class Keypad extends StatelessWidget {
  final void Function(String, bool) onValueKeyPressed;
  final KeypadType keypadType;
  final VoidCallback onDeleteKeyPressed;
  final VoidCallback onSubmitKeyPressed;
  final VoidCallback onSaleHistoryKeyPressed;
  final VoidCallback onSalePriceHistoryKeyPressed;

  const Keypad({
    super.key,
    required this.keypadType,
    required this.onValueKeyPressed,
    required this.onDeleteKeyPressed,
    required this.onSubmitKeyPressed,
    required this.onSaleHistoryKeyPressed,
    required this.onSalePriceHistoryKeyPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return DefaultTextStyle(
      style: textTheme.displaySmall!.copyWith(
        fontSize: 28.0,
        fontWeight: FontWeight.w100,
        color: colorScheme.onSurface,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: LayoutBuilder(
              builder: (_, constraints) {
                final size = constraints.maxWidth / 3;
                return Wrap(
                  children: [
                    ...List.generate(9, (index) {
                      final valueKey = (index + 1).toString();
                      return SizedBox.square(
                        dimension: size,
                        child: ValueInputKey(
                          label: valueKey,
                          onKeyPressed: () {
                            onValueKeyPressed(valueKey, false);
                          },
                        ),
                      );
                    }),
                    SizedBox.square(
                      dimension: size,
                      child: ValueInputKey(
                        label: keypadType == KeypadType.amount ? "00" : ".",
                        onKeyPressed: () {
                          onValueKeyPressed(keypadType == KeypadType.amount ? "00" : ".", true);
                        },
                      ),
                    ),
                    SizedBox.square(
                      dimension: size,
                      child: ValueInputKey(
                        label: "0",
                        onKeyPressed: () {
                          onValueKeyPressed("0", true);
                        },
                      ),
                    ),
                    SizedBox.square(
                      dimension: size,
                      child: IconInputKey(
                        icon: Symbols.backspace_rounded,
                        color: colorScheme.onSurface,
                        bgColor: colorScheme.surface,
                        onKeyPressed: onDeleteKeyPressed,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Wrap(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: IconInputKey(
                    icon: Symbols.list_alt_rounded,
                    color: colorScheme.primary,
                    bgColor: colorScheme.surface,
                    onKeyPressed: onSaleHistoryKeyPressed,
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: IconInputKey(
                    icon: Symbols.price_check_rounded,
                    color: colorScheme.primary,
                    bgColor: colorScheme.surface,
                    onKeyPressed: onSalePriceHistoryKeyPressed,
                  ),
                ),
                AspectRatio(
                  aspectRatio: 0.5,
                  child: IconInputKey(
                    icon: Symbols.done_rounded,
                    color: colorScheme.onPrimary,
                    bgColor: colorScheme.primary,
                    onKeyPressed: onSubmitKeyPressed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
