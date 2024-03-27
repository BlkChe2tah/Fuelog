import 'package:petrol_ledger/core/data/model/sale.dart';
import 'package:petrol_ledger/core/database/models/sale_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';

void main() {
  group('SaleEntity to Map converting test', () {
    test('ID not null', () {
      const saleEntity = SaleEntity(
        id: 0,
        name: "",
        amount: 0,
        salePriceId: 0,
        liter: 0,
        createdAt: 0,
      );
      expect(SaleEntity.fromMap(saleEntity.toMap()), saleEntity);
    });
    test('ID null', () {
      const saleEntity = SaleEntity(
        id: null,
        name: null,
        amount: 0,
        salePriceId: 0,
        liter: 0,
        createdAt: 0,
      );
      expect(SaleEntity.fromMap(saleEntity.toMap()), saleEntity);
    });
  });

  group("SaleEntity to ui Model converting test", () {
    test("return sale's ui model if converting success", () {
      // arrange
      const salePriceEntity = SalePriceEntity(
        id: 0,
        price: 0,
        createdAt: 0,
      );
      const saleEntity = SaleEntity(
        id: 0,
        name: "",
        amount: 0,
        salePriceId: 0,
        liter: 0,
        createdAt: 0,
      );
      // act
      final result = saleEntity.toSaleUiModel(salePriceEntity);
      // assert
      expect(
          result,
          Sale(
            saleId: saleEntity.id!,
            salePriceId: saleEntity.salePriceId,
            name: saleEntity.name,
            amount: saleEntity.amount,
            liter: saleEntity.liter,
            salePrice: salePriceEntity.price,
            date: DateTime.fromMillisecondsSinceEpoch(saleEntity.createdAt),
          ));
    });
    test("throw exception if sale price entity's id value null", () {
      // arrange
      const salePriceEntity = SalePriceEntity(
        id: 0,
        price: 0,
        createdAt: 0,
      );
      const saleEntity = SaleEntity(
        id: 0,
        name: "",
        amount: 0,
        salePriceId: 0,
        liter: 0,
        createdAt: 0,
      );
      // act
      final call = saleEntity.toSaleUiModel;
      // assert
      expect(() => call(salePriceEntity), throwsA(isA<Exception>()));
    });
  });
}
