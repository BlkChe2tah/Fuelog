import 'package:flutter/material.dart';
import 'package:petrol_ledger/features/history/view/sale_item_container.dart';

class SaleItem extends StatelessWidget {
  static const width = _dateItemWidth +
      _amountItemWidth +
      _literItemWidth +
      _salePriceItemWidth +
      _nameItemWidth;
  static const _dateItemWidth = 140.0;
  static const _amountItemWidth = 120.0;
  static const _literItemWidth = 120.0;
  static const _salePriceItemWidth = 120.0;
  static const _nameItemWidth = 240.0;

  final double height;
  final Color color;
  final Widget date;
  final Widget amount;
  final Widget liter;
  final Widget salePrice;
  final Widget name;

  const SaleItem({
    super.key,
    required this.height,
    required this.date,
    required this.amount,
    required this.liter,
    required this.salePrice,
    required this.name,
    required this.color,
  });

  static Text loadTextView({required String label, TextStyle? style}) {
    return Text(
      label,
      maxLines: 1,
      style: style,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Row(
        children: [
          SaleItemContainer(
            width: _dateItemWidth,
            height: height,
            child: date,
          ),
          SaleItemContainer(
            width: _amountItemWidth,
            height: height,
            child: amount,
          ),
          SaleItemContainer(
            width: _literItemWidth,
            height: height,
            child: liter,
          ),
          SaleItemContainer(
            width: _salePriceItemWidth,
            height: height,
            child: salePrice,
          ),
          SaleItemContainer(
            width: _nameItemWidth,
            height: height,
            child: name,
          ),
        ],
      ),
    );
  }
}
