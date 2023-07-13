import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:petrol_ledger/model/sale.dart';
import 'package:petrol_ledger/model/sale_price.dart';
import 'package:petrol_ledger/core/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' as sqlite;

class SQLiteSaleDatabase {
  static SQLiteSaleDatabase? _saleDatabase;

  SQLiteSaleDatabase._();

  static SQLiteSaleDatabase get instance {
    return _saleDatabase ??= SQLiteSaleDatabase._();
  }

  Future<Database> open() async {
    try {
      var dbPath = Platform.isAndroid
          ? await sqlite.getDatabasesPath()
          : (await getLibraryDirectory()).path;
      return await sqlite.openDatabase(
        p.join(dbPath, dbName),
        onCreate: _onDBCreate,
        version: 1,
      );
    } catch (e) {
      throw Exception('$dbName cannot open');
    }
  }

  Future<void> close() async {
    await _saleDatabase?.close();
  }

  Future<void> _onDBCreate(Database db, int version) async {
    await db.execute(_loadSalePriceTableSchema());
    await db.execute(_loadSaleTableSchema());
  }

  String _loadSalePriceTableSchema() {
    var salePriceColumnId =
        '${SalePrice.columnId} INTEGER PRIMARY KEY AUTOINCREMENT';
    var salePriceColumnPrice = '${SalePrice.columnPrice} INTEGER';
    var salePriceColumnCreatedAt = '${SalePrice.columnCreatedAt} INTEGER';
    return 'CREATE TABLE ${SalePrice.tableName}($salePriceColumnId, $salePriceColumnPrice, $salePriceColumnCreatedAt);';
  }

  String _loadSaleTableSchema() {
    var saleColumnId = '${Sale.columnId} INTEGER PRIMARY KEY AUTOINCREMENT';
    var saleColumnName = '${Sale.columnName} TEXT';
    var saleColumnAmount = '${Sale.columnAmount} INTEGER';
    var saleColumnSalePrice = '${Sale.columnSalePriceId} INTEGER';
    var saleColumnLiter = '${Sale.columnLiter} REAL';
    var saleColumnCreatedAt = '${Sale.columnCreatedAt} INTEGER';
    var foreignKeyConfig =
        'FOREIGN KEY(${Sale.columnSalePriceId}) REFERENCES ${SalePrice.tableName}(${SalePrice.columnId})';
    return 'CREATE TABLE ${Sale.tableName}($saleColumnId, $saleColumnName, $saleColumnAmount, $saleColumnSalePrice, $saleColumnLiter, $saleColumnCreatedAt, $foreignKeyConfig);';
  }
}
