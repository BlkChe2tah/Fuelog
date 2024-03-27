import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/core/design_system/values.dart';
import 'package:petrol_ledger/core/ui/new_sale_price_content_header.dart';

class NewSalePriceContentLayout extends StatefulWidget {
  static const double _minAmount = 200;
  static const double _maxAmount = 10000;
  static const double _defaultAmount = 1000;
  final bool showHintView;
  final int? latestSalePrice;

  const NewSalePriceContentLayout({super.key, this.showHintView = false, this.latestSalePrice});

  @override
  State<NewSalePriceContentLayout> createState() => _NewSalePriceContentLayoutState();
}

class _NewSalePriceContentLayoutState extends State<NewSalePriceContentLayout> {
  double _priceValue = NewSalePriceContentLayout._defaultAmount;

  @override
  void initState() {
    final latestPrice = widget.latestSalePrice;
    if (latestPrice != null) {
      _priceValue = latestPrice.toDouble();
    }
    super.initState();
  }

  void _priceValueDecreasedByOne() {
    if (_priceValue != NewSalePriceContentLayout._minAmount) {
      setState(() {
        _priceValue -= 1;
      });
    }
  }

  void _priceValueIncreasedByOne() {
    if (_priceValue != NewSalePriceContentLayout._maxAmount) {
      setState(() {
        _priceValue += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      constraints: const BoxConstraints.tightFor(width: 360),
      padding: const EdgeInsets.all(kXLarge),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: kLarge),
          NewSalePriceContentHeader(price: _priceValue.toStringAsFixed(0)),
          const SizedBox(height: kXLarge),
          Row(
            children: [
              IconButton(
                onPressed: _priceValueDecreasedByOne,
                icon: const Icon(
                  Symbols.remove_rounded,
                  size: 28.0,
                  weight: 300,
                ),
              ),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    sliderTheme: SliderThemeData(
                      trackHeight: 1,
                      inactiveTrackColor: colorScheme.outlineVariant,
                    ),
                  ),
                  child: Slider(
                    min: NewSalePriceContentLayout._minAmount,
                    max: NewSalePriceContentLayout._maxAmount,
                    divisions: (NewSalePriceContentLayout._maxAmount - NewSalePriceContentLayout._minAmount).toInt(),
                    value: _priceValue,
                    onChanged: (value) {
                      setState(() {
                        _priceValue = value;
                      });
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: _priceValueIncreasedByOne,
                icon: const Icon(
                  Symbols.add_rounded,
                  size: 28.0,
                  weight: 300,
                ),
              ),
            ],
          ),
          const SizedBox(height: kXLarge),
          SizedBox(
            height: kButtonSize,
            child: FilledButton(
              onPressed: () {
                Navigator.pop(context, _priceValue.toInt());
              },
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
              ),
              child: Text(
                'OK',
                style: textTheme.labelLarge?.copyWith(fontSize: 18.0),
              ),
            ),
          ),
          Visibility(
            visible: widget.showHintView,
            child: Padding(
              padding: const EdgeInsets.only(top: kLarge),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Symbols.info,
                    color: colorScheme.onSurfaceVariant,
                    size: 20.0,
                  ),
                  const SizedBox(width: kSmall),
                  Text(
                    'Please specify the sale price first',
                    style: textTheme.labelLarge?.copyWith(
                      fontSize: 15.0,
                      color: colorScheme.onSurfaceVariant,
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
