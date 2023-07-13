import 'package:equatable/equatable.dart';

class Sale extends Equatable {
  static const String tableName = 'sales';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnSalePriceId = 'sale_price_id';
  static const String columnAmount = 'amount';
  static const String columnLiter = 'liter';
  static const String columnCreatedAt = 'created_at';

  final int? id;
  final String? name;
  final int salePriceId;
  final int amount;
  final num liter;
  final int createdAt;

  @override
  List<Object?> get props => [id, name, salePriceId, amount, liter, createdAt];

  const Sale({
    this.id,
    this.name,
    required this.amount,
    required this.salePriceId,
    required this.liter,
    required this.createdAt,
  });

  static Map<String, dynamic> toMap(Sale sale) {
    var tName = (sale.name != null && sale.name!.isEmpty) ? null : sale.name;
    return {
      Sale.columnId: sale.id,
      Sale.columnName: tName,
      Sale.columnAmount: sale.amount,
      Sale.columnSalePriceId: sale.salePriceId,
      Sale.columnLiter: sale.liter,
      Sale.columnCreatedAt: sale.createdAt,
    };
  }

  static Sale fromMap(Map<String, dynamic> data) {
    return Sale(
      id: data[Sale.columnId],
      name: data[Sale.columnName],
      amount: data[Sale.columnAmount],
      salePriceId: data[Sale.columnSalePriceId],
      liter: data[Sale.columnLiter],
      createdAt: data[Sale.columnCreatedAt],
    );
  }

  @override
  String toString() {
    return 'Sale{${Sale.columnId}: $id, ${Sale.columnName}: $name, ${Sale.columnAmount}: $amount, ${Sale.columnSalePriceId}: $salePriceId, ${Sale.columnLiter}: $liter, ${Sale.columnCreatedAt}: $createdAt}';
  }
}
