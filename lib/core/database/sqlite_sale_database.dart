import 'package:meta/meta.dart';
import 'package:petrol_ledger/core/database/dao/sale_dao.dart';
import 'package:petrol_ledger/core/database/dao/sale_price_dao.dart';
import 'package:petrol_ledger/core/database/data_holder.dart';
import 'package:petrol_ledger/core/database/models/sale_entity.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';
import 'package:petrol_ledger/injection_container.dart';
import 'package:sqflite/sqflite.dart';

@sealed
class SQLiteSaleDatabase implements DataHolder {
  static const name = 'petrol_sale.db';

  @override
  late final SalePriceDAO salePriceDAO;

  @override
  late final SaleDAO saleDAO;

  SQLiteSaleDatabase(Database database) {
    salePriceDAO = $sl();
    saleDAO = $sl();
  }

  static String createSaleTableScheme() {
    var saleColumnId = '${SaleEntity.columnId} INTEGER PRIMARY KEY AUTOINCREMENT';
    var saleColumnName = '${SaleEntity.columnName} TEXT';
    var saleColumnAmount = '${SaleEntity.columnAmount} INTEGER';
    var saleColumnSalePrice = '${SaleEntity.columnSalePriceId} INTEGER';
    var saleColumnLiter = '${SaleEntity.columnLiter} REAL';
    var saleColumnCreatedAt = '${SaleEntity.columnCreatedAt} INTEGER';
    var foreignKeyConfig = 'FOREIGN KEY(${SaleEntity.columnSalePriceId}) REFERENCES ${SalePriceEntity.tableName}(${SalePriceEntity.columnId})';
    return 'CREATE TABLE ${SaleEntity.tableName}($saleColumnId, $saleColumnName, $saleColumnAmount, $saleColumnSalePrice, $saleColumnLiter, $saleColumnCreatedAt, $foreignKeyConfig);';
  }

  static String createSalePriceTableScheme() {
    var salePriceColumnId = '${SalePriceEntity.columnId} INTEGER PRIMARY KEY AUTOINCREMENT';
    var salePriceColumnPrice = '${SalePriceEntity.columnPrice} INTEGER';
    var salePriceColumnCreatedAt = '${SalePriceEntity.columnCreatedAt} INTEGER';
    return 'CREATE TABLE ${SalePriceEntity.tableName}($salePriceColumnId, $salePriceColumnPrice, $salePriceColumnCreatedAt);';
  }
}
