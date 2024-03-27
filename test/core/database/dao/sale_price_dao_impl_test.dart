import 'package:flutter_test/flutter_test.dart';
import 'package:petrol_ledger/core/database/dao/sale_price_dao.dart';
import 'package:petrol_ledger/core/database/dao/sale_price_dao_impl.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';
import 'package:petrol_ledger/core/database/sqlite_sale_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  const datas = [
    SalePriceEntity(id: 1, price: 0, createdAt: 0),
    SalePriceEntity(id: 2, price: 0, createdAt: 1)
  ];

  late final Database db;
  late final SalePriceDAO dao;

  setUpAll(() async {
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute(SQLiteSaleDatabase.createSalePriceTableScheme());
    dao = SalePriceDAOImpl(db);
  });

  tearDown(() async {
    await db.delete(SalePriceEntity.tableName);
  });

  test("return 0 when the database is newly created", () async {
    // arrange
    // act
    final result = await dao.getSalePrices();
    // assert
    expect(result.length, 0);
  });

  test("add new sale price data", () async {
    // arrange
    await dao.upsertSalePrice(datas.first);
    // act
    final result = await db.query(SalePriceEntity.tableName);
    // assert
    expect(result.length, 1);
    expect(result.map((e) => SalePriceEntity.fromMap(e)).toList(), [
      datas.first
    ]);
  });

  test("update sale price data if newly added sale data is already in the database", () async {
    // arrange
    await dao.upsertSalePrice(datas.first);
    await dao.upsertSalePrice(datas.first);
    // act
    final result = await db.query(SalePriceEntity.tableName);
    // assert
    expect(result.map((e) => SalePriceEntity.fromMap(e)).toList(), [
      datas.first
    ]);
  });

  test("load latest added sale price record", () async {
    // arrange
    for (var element in datas) {
      await db.insert(SalePriceEntity.tableName, element.toMap());
    }
    // act
    final result = await dao.getLatestSalePrice();
    // assert
    expect(result, datas.last);
  });

  test("return null if sale price record is empty", () async {
    // arrange
    // act
    final result = await dao.getLatestSalePrice();
    // assert
    expect(result, null);
  });

  test("load all sale price record", () async {
    // arrange
    for (var element in datas) {
      await db.insert(SalePriceEntity.tableName, element.toMap());
    }
    // act
    final result = await dao.getSalePrices();
    // assert
    expect(result.length, 2);
    expect(result, datas);
  });

  test("delete all sale price data record", () async {
    // arrange
    await db.insert(SalePriceEntity.tableName, datas.first.toMap());
    // act
    final deleteCount = await dao.deleteSalePrices();
    // assert
    final saleDatas = await db.query(SalePriceEntity.tableName);
    expect(deleteCount, 1);
    expect(saleDatas, isEmpty);
  });
}
