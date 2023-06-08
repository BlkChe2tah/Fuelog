import 'package:flutter/material.dart';
import 'package:petrol_ledger/model/sale_price_item_data.dart';
import 'package:petrol_ledger/res/colors.dart';
import 'package:petrol_ledger/res/values.dart';
import 'package:petrol_ledger/utils/extension.dart';

class SalePriceHistoryItemCard extends StatelessWidget {
  final SalePriceItemData data;
  const SalePriceHistoryItemCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var priceStateColor =
        data.isIncreased ? kPriceIncreaseColor : kPriceDecreaseColor;
    var priceStateText = data.isIncreased ? '+' : '-';
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: kXLarge, vertical: kLarge),
      margin: const EdgeInsets.fromLTRB(kLarge, kSmall, kLarge, kSmall),
      decoration: BoxDecoration(
        color: context.loadColorScheme().surface,
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
                    style: context.loadTextTheme().labelMedium?.copyWith(
                          color: context.loadColorScheme().onSurfaceVariant,
                        ),
                  ),
                  TextSpan(
                    text: '\n${data.price}',
                    style: context.loadTextTheme().headlineLarge?.copyWith(
                          fontFamily: 'anonymous pro',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                  ),
                  TextSpan(
                    text: 'Ks',
                    style: context.loadTextTheme().labelLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: kSmall),
          Visibility(
            visible: data.diffPrice != "0",
            child: RichText(
              textAlign: TextAlign.center,
              maxLines: 2,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$priceStateText${data.diffPrice}',
                    style: context.loadTextTheme().labelLarge?.copyWith(
                          color: priceStateColor,
                          fontFamily: 'anonymous pro',
                          fontSize: 18.0,
                        ),
                  ),
                  TextSpan(
                    text: 'Ks',
                    style: context.loadTextTheme().labelLarge?.copyWith(
                          color: priceStateColor,
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
