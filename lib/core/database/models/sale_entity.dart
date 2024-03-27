import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:petrol_ledger/core/data/model/sale.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';

@sealed
class SaleEntity extends Equatable {
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

  const SaleEntity({
    this.id,
    this.name,
    required this.amount,
    required this.salePriceId,
    required this.liter,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnName: name,
      columnAmount: amount,
      columnSalePriceId: salePriceId,
      columnLiter: liter,
      columnCreatedAt: createdAt,
    };
  }

  static SaleEntity fromMap(Map<String, dynamic> data) {
    return SaleEntity(
      id: data[columnId],
      name: data[columnName],
      amount: data[columnAmount],
      salePriceId: data[columnSalePriceId],
      liter: data[columnLiter],
      createdAt: data[columnCreatedAt],
    );
  }

  @override
  List<Object?> get props => [
        id,
        salePriceId,
      ];

  @override
  String toString() {
    return 'Sale{$columnId: $id, $columnName: $name, $columnAmount: $amount, $columnSalePriceId: $salePriceId, $columnLiter: $liter, $columnCreatedAt: $createdAt}';
  }
}

extension SaleEntityExt on SaleEntity {
  Sale toSaleUiModel(SalePriceEntity salePrice) {
    if (id == null) throw Exception("SaleEntity.id must not be null when converting to ui model");
    return Sale(
      saleId: id!,
      salePriceId: salePriceId,
      name: name,
      amount: amount,
      liter: liter,
      salePrice: salePrice.price,
      date: DateTime.fromMillisecondsSinceEpoch(createdAt),
    );
  }
}
