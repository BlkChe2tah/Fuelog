import 'package:flutter/material.dart';
import 'package:petrol_ledger/features/collect/domain/sale_price_collect_provider.dart';
import 'package:petrol_ledger/core/utils/extension.dart';
import 'package:provider/provider.dart';

class SalePriceCollectHeader extends StatelessWidget {
  const SalePriceCollectHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "Sale Price\n",
            style: context.loadTextTheme().labelLarge?.copyWith(
                  color: context.loadColorScheme().onSurfaceVariant,
                  fontSize: 18.0,
                ),
          ),
          TextSpan(
            text: context
                .select<SalePriceCollectProvider, double>(
                  (provider) => provider.salePrice,
                )
                .toStringAsFixed(0),
            style: context.loadTextTheme().displayLarge?.copyWith(
                  fontFamily: 'anonymous pro',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.6,
                ),
          ),
          TextSpan(
            text: 'Ks',
            style: context.loadTextTheme().headlineSmall,
          ),
        ],
      ),
    );
  }
}
