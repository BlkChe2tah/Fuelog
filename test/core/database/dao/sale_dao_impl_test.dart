import 'package:flutter_test/flutter_test.dart';
import 'package:petrol_ledger/core/database/dao/sale_dao.dart';
import 'package:petrol_ledger/core/database/dao/sale_dao_impl.dart';
import 'package:petrol_ledger/core/database/models/sale_entity.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';
import 'package:petrol_ledger/core/database/models/sale_sale_price_cross_ref.dart';
import 'package:petrol_ledger/core/database/sqlite_sale_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  final date = DateTime(2000, 1, 1);
  final datas = [
    SaleEntity(id: 1, name: null, amount: 0, salePriceId: 1, liter: 0, createdAt: date.millisecondsSinceEpoch),
    SaleEntity(id: 2, name: null, amount: 0, salePriceId: 2, liter: 0, createdAt: date.add(const Duration(days: 1)).millisecondsSinceEpoch),
  ];

  late final Database db;
  late final SaleDAO dao;

  setUpAll(() async {
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute(SQLiteSaleDatabase.createSalePriceTableScheme());
    await db.execute(SQLiteSaleDatabase.createSaleTableScheme());
    dao = SaleDAOImpl(db);
  });

  tearDown(() async {
    await db.delete(SalePriceEntity.tableName);
    await db.delete(SaleEntity.tableName);
  });

  test("return 0 when the database is newly created", () async {
    // arrange
    // act
    final result = await dao.getSalesCount();
    // assert
    expect(result, 0);
  });

  test("return all sale record count", () async {
    // arrange
    for (var data in datas) {
      await db.insert(SaleEntity.tableName, data.toMap());
    }
    // act
    final result = await dao.getSalesCount();
    // assert
    expect(result, 2);
  });

  test("return sale record count for filter date", () async {
    // arrange
    for (var data in datas) {
      await db.insert(SaleEntity.tableName, data.toMap());
    }
    // act
    final result = await dao.getSalesCountForOneDay(date);
    final result2 = await dao.getSalesCountForOneDay(date.add(const Duration(days: 1)));
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
    db.insert(SaleEntity.tableName, data.toMap());
    // act
    final result = await dao.getSalesCountForOneDay(DateTime(1));
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
    await dao.upsertSaleData(data);
    // act
    final result = await db.query(SaleEntity.tableName);
    // assert
    expect(result.length, 1);
    expect(result.map((e) => SaleEntity.fromMap(e)).toList(), [
      data
    ]);
  });

  test("update sale data if newly added sale data is already in the database", () async {
    // arrange
    const data = SaleEntity(
      id: 1,
      name: null,
      amount: 0,
      salePriceId: 1,
      liter: 0,
      createdAt: 0,
    );
    await dao.upsertSaleData(data);
    await dao.upsertSaleData(data);
    // act
    final result = await db.query(SaleEntity.tableName);
    // assert
    expect(result.map((e) => SaleEntity.fromMap(e)).toList(), [
      data
    ]);
  });

  test("load all sale data combined with sale price data", () async {
    const matchResult = SaleSalePriceCrossRef(
      saleId: 1,
      salePriceId: 1,
      amount: 0,
      liter: 0,
      saleCreatedAt: 0,
      priceId: 1,
      salePrice: 0,
      salePriceCreatedAt: 0,
    );
    // arrange
    const salePrice = SalePriceEntity(
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
    await db.insert(SalePriceEntity.tableName, salePrice.toMap());
    await db.insert(SaleEntity.tableName, sale.toMap());
    // act
    final result = await dao.getSales();
    // assert
    expect(result.length, 1);
    expect(result, [
      matchResult
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
    await db.insert(SalePriceEntity.tableName, salePrice.toMap());
    await db.insert(SaleEntity.tableName, sale.toMap());
    await db.insert(SaleEntity.tableName, sale2.toMap());
    // act
    final result = await dao.getSales(DateTime(2019, 1, 1));
    final result2 = await dao.getSales(DateTime(2019, 1, 2));
    // assert
    expect(result.length, 1);
    expect(result2.length, 1);
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
    await db.insert(SaleEntity.tableName, data.toMap());
    // act
    final deleteCount = await dao.deleteSales();
    // assert
    final saleDatas = await db.query(SaleEntity.tableName);
    expect(deleteCount, 1);
    expect(saleDatas, isEmpty);
  });
}
