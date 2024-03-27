import 'package:flutter_test/flutter_test.dart';
import 'package:petrol_ledger/core/data/repository/sale_repository_impl.dart';
import 'package:petrol_ledger/core/database/models/sale_entity.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';
import 'package:petrol_ledger/core/database/models/sale_sale_price_cross_ref.dart';

import '../../database/fake_sqlite_sale_database.dart';

void main() {
  final date = DateTime(2000, 1, 1);
  final datas = [
    SaleEntity(id: 1, name: null, amount: 0, salePriceId: 1, liter: 0, createdAt: date.millisecondsSinceEpoch),
    SaleEntity(id: 2, name: null, amount: 0, salePriceId: 2, liter: 0, createdAt: date.add(const Duration(days: 1)).millisecondsSinceEpoch),
  ];

  final fakeDataHolder = FakeSQLiteSaleDatabase();
  final repo = SaleRepositoryImpl(fakeDataHolder);

  tearDown(() async {
    fakeDataHolder.saleDAO.deleteAll();
  });

  test("return 0 when the database is newly created", () async {
    // arrange
    // act
    final result = await repo.getSalesCount();
    // assert
    expect(result, 0);
  });

  test("return all sale record count", () async {
    // arrange
    fakeDataHolder.saleDAO.setupData([], datas);
    // act
    final result = await repo.getSalesCount();
    // assert
    expect(result, datas.length);
  });

  test("return sale record count for filter date", () async {
    // arrange
    fakeDataHolder.saleDAO.setupData([], datas);
    // act
    final result = await repo.getSalesCountForOneDay(date);
    final result2 = await repo.getSalesCountForOneDay(date.add(const Duration(days: 1)));
    // assert
    expect(result, 1);
    expect(result2, 1);
  });

  test("return sale record count 0 if the record does not have for filter date", () async {
    // arrange
    final date = DateTime(0);
    final data = SaleEntity(
      id: 1,
      name: null,
      amount: 0,
      salePriceId: 1,
      liter: 0,
      createdAt: date.millisecondsSinceEpoch,
    );
    fakeDataHolder.saleDAO.setupData([], [
      data
    ]);
    // act
    final result = await repo.getSalesCountForOneDay(DateTime(1));
    // assert
    expect(result, 0);
  });

  test("add new sale data", () async {
    // arrange
    const data = SaleEntity(
      id: 1,
      name: null,
      amount: 0,
      salePriceId: 1,
      liter: 0,
      createdAt: 0,
    );
    // act
    await repo.addNewSale(
      name: data.name,
      amount: data.amount.toString(),
      salePriceId: data.salePriceId,
      liter: data.liter.toString(),
      date: DateTime.fromMillisecondsSinceEpoch(data.createdAt),
    );
    // assert
    expect(fakeDataHolder.saleDAO.sales.length, 1);
    expect(fakeDataHolder.saleDAO.sales, [
      data
    ]);
  });

  test("load all sale data combined with sale price data", () async {
    // arrange
    const salePrice = SalePriceEntity(
      id: 1,
      price: 0,
      createdAt: 0,
    );
    const sale = SaleEntity(
      id: 1,
      amount: 0,
      salePriceId: 1,
      liter: 0,
      createdAt: 0,
    );
    fakeDataHolder.saleDAO.setupData([
      salePrice
    ], [
      sale
    ]);
    // act
    final result = await repo.getSales();
    // assert
    // expect(result.length, 1);
    expect(result, [
      const SaleSalePriceCrossRef(saleId: 1, salePriceId: 1, amount: 0, liter: 0, saleCreatedAt: 0, priceId: 1, salePrice: 0, salePriceCreatedAt: 0).toSaleUiModel(),
    ]);
  });

  test("load all sale data combined with sale price data by filtering date", () async {
    // arrange
    const salePrice = SalePriceEntity(
      id: 1,
      price: 0,
      createdAt: 0,
    );
    final sale = SaleEntity(
      id: 1,
      amount: 0,
      salePriceId: 1,
      liter: 0,
      createdAt: DateTime(2019, 1, 1).millisecondsSinceEpoch,
    );
    final sale2 = SaleEntity(
      id: 2,
      amount: 0,
      salePriceId: 1,
      liter: 0,
      createdAt: DateTime(2019, 1, 2).millisecondsSinceEpoch,
    );
    fakeDataHolder.saleDAO.setupData([
      salePrice
    ], [
      sale,
      sale2,
    ]);
    // act
    final result = await repo.getSales(DateTime(2019, 1, 1));
    final result2 = await repo.getSales(DateTime(2019, 1, 2));
    // assert
    // expect(result.length, 1);
    expect(result, [
      sale.toSaleUiModel(salePrice)
    ]);
    // expect(result2.length, 1);
    expect(result2, [
      sale2.toSaleUiModel(salePrice)
    ]);
  });

  test("delete all sale data record", () async {
    // arrange
    const data = SaleEntity(
      id: 1,
      name: null,
      amount: 0,
      salePriceId: 1,
      liter: 0,
      createdAt: 0,
    );
    fakeDataHolder.saleDAO.setupData([], [
      data
    ]);
    // act
    await repo.deleteSales();
    // assert
    expect(fakeDataHolder.saleDAO.sales.length, 0);
  });
}
