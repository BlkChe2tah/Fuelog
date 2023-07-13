import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/features/amount_collect/amount_confirm_screen_provider.dart';
import 'package:petrol_ledger/core/values.dart';
import 'package:petrol_ledger/core/utils/extension.dart';
import 'package:provider/provider.dart';

class SaleAmountView extends StatelessWidget {
  const SaleAmountView({super.key});

  @override
  Widget build(BuildContext context) {
    var prefixAmountTextStyle = context.loadTextTheme().displayMedium?.copyWith(
          fontFamily: 'anonymous pro',
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        );
    var suffixLabelTextStyle = context.loadTextTheme().labelLarge;
    return Column(
      children: [
        Text(
          'AMOUNT',
          style: context.loadTextTheme().headlineSmall?.copyWith(
                letterSpacing: 1.2,
                fontSize: 20.0,
                color: context.loadColorScheme().onSurfaceVariant,
              ),
        ),
        const SizedBox(height: kMedium),
        RichText(
          maxLines: 1,
          text: TextSpan(
            text: context
                .read<AmountConfirmScreenProvider>()
                .liter
                .toStringAsFixed(3),
            style: prefixAmountTextStyle?.copyWith(
              fontSize: 28.0,
            ),
            children: [
              TextSpan(
                text: 'Liter',
                style: suffixLabelTextStyle?.copyWith(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kMedium),
          child: RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Symbols.multiple_stop_sharp,
              size: 24.0,
              color: context.loadColorScheme().onSurfaceVariant,
              weight: 400,
            ),
          ),
        ),
        RichText(
          maxLines: 1,
          text: TextSpan(
            text: context.read<AmountConfirmScreenProvider>().amount.toString(),
            style: prefixAmountTextStyle,
            children: [
              TextSpan(
                text: 'Ks',
                style: suffixLabelTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
