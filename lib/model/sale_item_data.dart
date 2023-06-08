import 'package:petrol_ledger/model/sale.dart';
import 'package:petrol_ledger/model/sale_price.dart';

class SaleItemData {
  final DateTime date;
  final int amount;
  final num liter;
  final int salePrice;
  final String name;

  SaleItemData({
    required this.date,
    required this.amount,
    required this.liter,
    required this.salePrice,
    required this.name,
  });

  static SaleItemData fromMap(Map<String, dynamic> data) {
    return SaleItemData(
      date: DateTime.fromMillisecondsSinceEpoch(data[Sale.columnCreatedAt]),
      amount: data[Sale.columnAmount],
      liter: data[Sale.columnLiter],
      salePrice: data[SalePrice.columnPrice],
      name: data[Sale.columnName] ?? '',
    );
  }

  @override
  String toString() {
    return "SaleItemData : {$date, $amount, $liter, $salePrice, $name}";
  }
}
