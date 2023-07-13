import 'package:petrol_ledger/model/sale.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Sale sale;
  late Sale saleWithNull;
  late Map<String, dynamic> map;
  late Map<String, dynamic> mapWithNull;

  setUp(() {
    const id = 1;
    const amount = 1000;
    const liter = 1.3;
    const salePriceId = 1;
    final createdAt = DateTime.now().millisecondsSinceEpoch;
    const name = "Testing One";

    sale = Sale(
      id: id,
      amount: amount,
      salePriceId: salePriceId,
      liter: liter,
      createdAt: createdAt,
      name: name,
    );

    saleWithNull = Sale(
      id: null,
      amount: amount,
      salePriceId: salePriceId,
      liter: liter,
      createdAt: createdAt,
      name: null,
    );

    map = {
      Sale.columnId: id,
      Sale.columnAmount: amount,
      Sale.columnLiter: liter,
      Sale.columnSalePriceId: salePriceId,
      Sale.columnCreatedAt: createdAt,
      Sale.columnName: name,
    };

    mapWithNull = {
      Sale.columnId: null,
      Sale.columnAmount: amount,
      Sale.columnLiter: liter,
      Sale.columnSalePriceId: salePriceId,
      Sale.columnCreatedAt: createdAt,
      Sale.columnName: null,
    };
  });

  group('Sale model to json converting test', () {
    test('Serialize', () {
      expect(Sale.toMap(sale), map);
    });

    test('Deserialize', () {
      expect(Sale.fromMap(map), sale);
    });
  });

  group('Sale model with null data to json converting test', () {
    test('Serialize', () {
      expect(Sale.toMap(saleWithNull), mapWithNull);
    });

    test('Deserialize', () {
      expect(Sale.fromMap(mapWithNull), saleWithNull);
    });
  });
}
