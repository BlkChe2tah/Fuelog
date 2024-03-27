import 'package:flutter_test/flutter_test.dart';
import 'package:petrol_ledger/core/data/model/sale_price.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';

void main() {
  group('SalePriceEntity to Map converting test', () {
    test('ID not null', () {
      const salePriceEntity = SalePriceEntity(
        id: 0,
        price: 0,
        createdAt: 0,
      );
      expect(SalePriceEntity.fromMap(salePriceEntity.toMap()), salePriceEntity);
    });
    test('ID null', () {
      const salePriceEntity = SalePriceEntity(
        id: null,
        price: 0,
        createdAt: 0,
      );
      expect(SalePriceEntity.fromMap(salePriceEntity.toMap()), salePriceEntity);
    });
  });

  group("SalePriceEntity to UI Model converting test", () {
    test("return sale pirce's ui model if converting success", () {
      // arrange
      const salePriceEntity = SalePriceEntity(
        id: 0,
        price: 0,
        createdAt: 0,
      );
      // act
      final result = salePriceEntity.toUiModel();
      // assert
      expect(result, SalePrice(id: 0, price: 0, createdAt: DateTime.fromMillisecondsSinceEpoch(0)));
    });
    test("throw exception if sale price entity's id value null", () {
      // arrange
      const salePriceEntity = SalePriceEntity(
        id: null,
        price: 0,
        createdAt: 0,
      );
      // act
      final call = salePriceEntity.toUiModel;
      // assert
      expect(() => call(), throwsA(isA<Exception>()));
    });
  });
}
