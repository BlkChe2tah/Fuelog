import 'package:flutter/material.dart';
import 'package:petrol_ledger/core/design_system/colors.dart';
import 'package:petrol_ledger/core/ui/components/sale_item_container.dart';

class SaleItemView extends StatelessWidget {
  static const width = _dateItemWidth + _amountItemWidth + _literItemWidth + _salePriceItemWidth + _nameItemWidth;
  static const _dateItemWidth = 140.0;
  static const _amountItemWidth = 120.0;
  static const _literItemWidth = 120.0;
  static const _salePriceItemWidth = 120.0;
  static const _nameItemWidth = 240.0;

  final double height;
  final Color color;
  final String date;
  final String amount;
  final String liter;
  final String salePrice;
  final String name;
  final TextStyle? style;

  const SaleItemView({
    super.key,
    required this.height,
    required this.date,
    required this.amount,
    required this.liter,
    required this.salePrice,
    required this.name,
    required this.color,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Row(
        children: [
          SaleItemContainer(
            width: _dateItemWidth,
            height: height,
            child: Text(date, style: style, maxLines: 1),
          ),
          SaleItemContainer(
            width: _amountItemWidth,
            height: height,
            child: Text(amount, style: style, maxLines: 1),
          ),
          SaleItemContainer(
            width: _literItemWidth,
            height: height,
            child: Text(liter, style: style, maxLines: 1),
          ),
          SaleItemContainer(
            width: _salePriceItemWidth,
            height: height,
            child: Text(salePrice, style: style, maxLines: 1),
          ),
          SaleItemContainer(
            width: _nameItemWidth,
            height: height,
            child: Text(name, style: style, maxLines: 1),
          ),
        ],
      ),
    );
  }
}

class SaleItemHeader extends StatelessWidget {
  const SaleItemHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SaleItemView(
      height: 42,
      date: "Time",
      amount: "Amount",
      liter: "Liter",
      salePrice: "Sale Price",
      name: "Debtor Name",
      color: colorScheme.surfaceVariant,
      style: textTheme.labelLarge?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class SaleItemBody extends StatelessWidget {
  final String date;
  final String amount;
  final String liter;
  final String salePrice;
  final String name;

  const SaleItemBody({
    super.key,
    required this.date,
    required this.amount,
    required this.liter,
    required this.salePrice,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SaleItemView(
      height: 48,
      date: date,
      amount: amount,
      liter: liter,
      salePrice: salePrice,
      name: name,
      color: name.isEmpty ? colorScheme.surface : kDebtorRowColor,
      style: textTheme.bodyMedium?.copyWith(
        color: name.isEmpty ? colorScheme.onSurface : colorScheme.onInverseSurface,
      ),
    );
  }
}
