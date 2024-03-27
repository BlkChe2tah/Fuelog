import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/core/design_system/values.dart';

class NewSaleConfirmContentHeader extends StatelessWidget {
  final String liter;
  final String amount;
  const NewSaleConfirmContentHeader({super.key, required this.liter, required this.amount});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final prefixAmountTextStyle = textTheme.displayMedium?.copyWith(
      fontFamily: 'anonymous pro',
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    );
    return Column(
      children: [
        Text(
          'AMOUNT',
          style: textTheme.labelLarge?.copyWith(
            letterSpacing: 1.2,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: kMedium),
        RichText(
          maxLines: 1,
          text: TextSpan(
            text: liter,
            style: prefixAmountTextStyle?.copyWith(
              fontSize: 20.0,
            ),
            children: [
              TextSpan(
                text: 'Liter',
                style: textTheme.labelLarge?.copyWith(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kSmall),
          child: RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Symbols.multiple_stop_sharp,
              size: 20.0,
              color: colorScheme.onSurfaceVariant,
              weight: 400,
            ),
          ),
        ),
        RichText(
          maxLines: 1,
          text: TextSpan(
            text: amount,
            style: prefixAmountTextStyle,
            children: [
              TextSpan(
                text: 'Ks',
                style: textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
