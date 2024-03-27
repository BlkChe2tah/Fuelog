import 'package:flutter/material.dart';
import 'package:petrol_ledger/core/design_system/values.dart';
import 'package:petrol_ledger/features/sale_price_history/model/sale_price_item_view_data.dart';

class SalePriceHistoryItemView extends StatelessWidget {
  final SalePriceItemViewData data;
  const SalePriceHistoryItemView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kXLarge, vertical: kLarge),
      margin: const EdgeInsets.fromLTRB(kLarge, kSmall, kLarge, kSmall),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              textAlign: TextAlign.start,
              maxLines: 2,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: data.date,
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  TextSpan(
                    text: '\n${data.salePrice}',
                    style: textTheme.headlineLarge?.copyWith(
                      fontFamily: 'anonymous pro',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  TextSpan(
                    text: 'Ks',
                    style: textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: kSmall),
          Visibility(
            visible: true,
            child: RichText(
              textAlign: TextAlign.center,
              maxLines: 2,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: data.diffPrice,
                    style: textTheme.labelLarge?.copyWith(
                      color: data.color,
                      fontFamily: 'anonymous pro',
                      fontSize: 18.0,
                    ),
                  ),
                  TextSpan(
                    text: 'Ks',
                    style: textTheme.labelLarge?.copyWith(
                      color: data.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
