import 'package:flutter_test/flutter_test.dart';
import 'package:petrol_ledger/core/data/model/sale.dart';
import 'package:petrol_ledger/core/database/models/sale_sale_price_cross_ref.dart';

void main() {
  group('SaleSalePriceCrossRef to Map converting test', () {
    test('name not null', () {
      const saleSalePriceCrossRef = SaleSalePriceCrossRef(
        saleId: 0,
        name: "",
        salePriceId: 0,
        amount: 0,
        liter: 0,
        saleCreatedAt: 0,
        priceId: 0,
        salePrice: 0,
        salePriceCreatedAt: 0,
      );
      expect(SaleSalePriceCrossRef.fromMap(saleSalePriceCrossRef.toMap()), saleSalePriceCrossRef);
    });
    test('name null', () {
      const saleSalePriceCrossRef = SaleSalePriceCrossRef(
        saleId: 0,
        name: null,
        salePriceId: 0,
        amount: 0,
        liter: 0,
        saleCreatedAt: 0,
        priceId: 0,
        salePrice: 0,
        salePriceCreatedAt: 0,
      );
      expect(SaleSalePriceCrossRef.fromMap(saleSalePriceCrossRef.toMap()), saleSalePriceCrossRef);
    });
  });

  test('SaleSalePriceCrossRef to Sale Ui Model converting test', () {
    // arrange
    const saleSalePriceCrossRef = SaleSalePriceCrossRef(
      saleId: 0,
      name: null,
      salePriceId: 0,
      amount: 0,
      liter: 0,
      saleCreatedAt: 0,
      priceId: 0,
      salePrice: 0,
      salePriceCreatedAt: 0,
    );
    // act
    final result = saleSalePriceCrossRef.toSaleUiModel();
    // assert
    expect(
      result,
      Sale(
        saleId: saleSalePriceCrossRef.saleId,
        salePriceId: saleSalePriceCrossRef.salePriceId,
        name: saleSalePriceCrossRef.name,
        amount: saleSalePriceCrossRef.amount,
        liter: saleSalePriceCrossRef.liter,
        salePrice: saleSalePriceCrossRef.salePrice,
        date: DateTime.fromMillisecondsSinceEpoch(saleSalePriceCrossRef.saleCreatedAt),
      ),
    );
  });
}
