import 'package:flutter_test/flutter_test.dart';
import 'package:petrol_ledger/core/data/repository/sale_price_repository_impl.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';

import '../../database/fake_sqlite_sale_database.dart';

void main() {
  final fakeDataHolder = FakeSQLiteSaleDatabase();
  final repo = SalePriceRepositoryImpl(fakeDataHolder);

  tearDown(() async {
    fakeDataHolder.salePriceDAO.deleteAll();
  });

  test("add new price", () async {
    // arrange
    const price = 0;
    final date = DateTime.fromMillisecondsSinceEpoch(0);
    // act
    await repo.addNewSalePrice(price: price, date: date);
    // assert
    expect(fakeDataHolder.salePriceDAO.salePrices.length, 1);
    expect(fakeDataHolder.salePriceDAO.salePrices.first, SalePriceEntity(id: 1, price: 0, createdAt: date.millisecondsSinceEpoch));
  });

  test("reurn null if sale price record is empty", () async {
    // arrange
    // act
    final result = await repo.loadLatestSalePrice();
    // assert
    expect(fakeDataHolder.salePriceDAO.salePrices.length, 0);
    expect(result, null);
  });

  test("reurn latest sale price data if sale price record is not empty", () async {
    // arrange
    final items = [
      const SalePriceEntity(id: 1, price: 1, createdAt: 1),
      const SalePriceEntity(id: 2, price: 2, createdAt: 2),
    ];
    fakeDataHolder.salePriceDAO.setupData(items);
    // act
    final result = await repo.loadLatestSalePrice();
    // assert
    expect(fakeDataHolder.salePriceDAO.salePrices.length, 2);
    expect(result, items.last.toUiModel());
  });

  test("reurn empty list if sale price record is empty", () async {
    // arrange
    // act
    final result = await repo.loadSalePrices();
    // assert
    expect(fakeDataHolder.salePriceDAO.salePrices.length, 0);
    expect(result, []);
  });

  test("reurn sale price ui model data if sale price record is not empty", () async {
    // arrange
    final items = [
      const SalePriceEntity(id: 1, price: 1, createdAt: 1),
      const SalePriceEntity(id: 2, price: 2, createdAt: 2),
    ];
    fakeDataHolder.salePriceDAO.setupData(items);
    // act
    final result = await repo.loadSalePrices();
    // assert
    expect(fakeDataHolder.salePriceDAO.salePrices.length, 2);
    expect(result, items.map((e) => e.toUiModel()).toList());
  });

  test("delete all sale price record", () async {
    // arrange
    final items = [
      const SalePriceEntity(id: 1, price: 1, createdAt: 1),
      const SalePriceEntity(id: 2, price: 2, createdAt: 2),
    ];
    fakeDataHolder.salePriceDAO.setupData(items);
    // act
    await repo.deleteSalePrices();
    // assert
    expect(fakeDataHolder.salePriceDAO.salePrices.length, 0);
  });
}
