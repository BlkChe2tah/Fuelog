import 'package:equatable/equatable.dart';
import 'package:petrol_ledger/core/data/model/sale.dart';
import 'package:petrol_ledger/core/database/models/sale_entity.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';

class SaleSalePriceCrossRef extends Equatable {
  static const String cSaleId = 'sale_id';
  static const String cPriceId = 'price_id';
  static const String cSaleCreatedAt = 'sale_created_at';
  static const String cSalePriceCreatedAt = 'sale_price_created_at';

  final int saleId;
  final String? name;
  final int salePriceId;
  final int amount;
  final num liter;
  final int saleCreatedAt;
  final int priceId;
  final int salePrice;
  final int salePriceCreatedAt;

  const SaleSalePriceCrossRef({
    required this.saleId,
    this.name,
    required this.salePriceId,
    required this.amount,
    required this.liter,
    required this.saleCreatedAt,
    required this.priceId,
    required this.salePrice,
    required this.salePriceCreatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      cSaleId: saleId,
      SaleEntity.columnName: name,
      SaleEntity.columnSalePriceId: salePriceId,
      SaleEntity.columnAmount: amount,
      SaleEntity.columnLiter: liter,
      cSaleCreatedAt: saleCreatedAt,
      cPriceId: priceId,
      SalePriceEntity.columnPrice: salePrice,
      cSalePriceCreatedAt: salePriceCreatedAt,
    };
  }

  static SaleSalePriceCrossRef fromMap(Map<String, dynamic> data) {
    return SaleSalePriceCrossRef(
      saleId: data[cSaleId],
      name: data[SaleEntity.columnName],
      salePriceId: data[SaleEntity.columnSalePriceId],
      amount: data[SaleEntity.columnAmount],
      liter: data[SaleEntity.columnLiter],
      saleCreatedAt: data[cSaleCreatedAt],
      priceId: data[cPriceId],
      salePrice: data[SalePriceEntity.columnPrice],
      salePriceCreatedAt: data[cSalePriceCreatedAt],
    );
  }

  @override
  List<Object?> get props => [
        saleId,
        salePriceId,
        priceId,
      ];

  @override
  String toString() {
    return "SaleSalePriceCrossRef : {$saleId, $name, $salePriceId, $amount, $liter, $saleCreatedAt, $priceId, $salePrice, $salePriceCreatedAt}";
  }
}

extension SaleSalePriceCrossRefExt on SaleSalePriceCrossRef {
  Sale toSaleUiModel() {
    return Sale(
      saleId: saleId,
      salePriceId: salePriceId,
      name: name,
      amount: amount,
      liter: liter,
      salePrice: salePrice,
      date: DateTime.fromMillisecondsSinceEpoch(saleCreatedAt),
    );
  }
}
