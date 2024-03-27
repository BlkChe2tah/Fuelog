import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:petrol_ledger/core/data/model/sale_price.dart';

@sealed
class SalePriceEntity extends Equatable {
  static const String tableName = 'sale_prices';
  static const String columnId = 'id';
  static const String columnPrice = 'price';
  static const String columnCreatedAt = 'created_at';

  final int? id;
  final int price;
  final int createdAt;

  const SalePriceEntity({
    this.id,
    required this.price,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnPrice: price,
      columnCreatedAt: createdAt,
    };
  }

  static SalePriceEntity fromMap(Map<String, dynamic> data) {
    return SalePriceEntity(
      id: data[columnId],
      price: data[columnPrice],
      createdAt: data[columnCreatedAt],
    );
  }

  @override
  List<Object?> get props => [
        id,
        price,
      ];

  @override
  String toString() {
    return 'SalePrice{$columnId: $id, $columnPrice: $price, $columnCreatedAt: $createdAt}';
  }
}

extension SalePriceEntityExt on SalePriceEntity {
  SalePrice toUiModel() {
    if (id == null) throw Exception("SalePriceEntity.id must not be null when converting to ui model");
    return SalePrice(id: id!, price: price, createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt));
  }
}
