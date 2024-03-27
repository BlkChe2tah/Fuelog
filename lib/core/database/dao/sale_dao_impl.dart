import 'package:meta/meta.dart';
import 'package:petrol_ledger/core/database/dao/sale_dao.dart';
import 'package:petrol_ledger/core/database/models/sale_entity.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';
import 'package:petrol_ledger/core/database/models/sale_sale_price_cross_ref.dart';
import 'package:sqflite/sqflite.dart';

@sealed
class SaleDAOImpl implements SaleDAO {
  final Database _database;
  SaleDAOImpl(Database database) : _database = database;

  @override
  Future<int> getSalesCount() async {
    final List<Map<String, dynamic>> queryResponse = await _database.rawQuery('SELECT COUNT(*) AS count FROM ${SaleEntity.tableName}');
    return queryResponse.first['count'];
  }

  @override
  Future<int> getSalesCountForOneDay(DateTime date) async {
    final List<Map<String, dynamic>> queryResponse = await _database.rawQuery('''
              SELECT COUNT(*) AS count FROM ${SaleEntity.tableName} 
              WHERE ${SaleEntity.tableName}.${SaleEntity.columnCreatedAt} >= ${date.millisecondsSinceEpoch} 
              AND ${SaleEntity.tableName}.${SaleEntity.columnCreatedAt} <= ${date.add(const Duration(days: 1)).millisecondsSinceEpoch}''');
    return queryResponse.first['count'];
  }

  @override
  Future<int> upsertSaleData(SaleEntity data) {
    return _database.insert(SaleEntity.tableName, data.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<int> deleteSales() {
    return _database.delete(SaleEntity.tableName);
  }

  @override
  Future<List<SaleSalePriceCrossRef>> getSales([DateTime? date]) async {
    const saleTableAlias = "S";
    const salePriceTableAlias = "SP";
    // start column
    const String saleId = '$saleTableAlias.${SaleEntity.columnId} AS ${SaleSalePriceCrossRef.cSaleId}';
    const String name = '$saleTableAlias.${SaleEntity.columnName}';
    const String salePriceId = '$saleTableAlias.${SaleEntity.columnSalePriceId}';
    const String amount = '$saleTableAlias.${SaleEntity.columnAmount}';
    const String liter = '$saleTableAlias.${SaleEntity.columnLiter}';
    const String saleCreatedAt = '$saleTableAlias.${SaleEntity.columnCreatedAt} AS ${SaleSalePriceCrossRef.cSaleCreatedAt}';
    const String priceId = '$salePriceTableAlias.${SalePriceEntity.columnId} AS ${SaleSalePriceCrossRef.cPriceId}';
    const String price = '$salePriceTableAlias.${SalePriceEntity.columnPrice}';
    const String salePriceCreatedAt = '$salePriceTableAlias.${SalePriceEntity.columnCreatedAt} AS ${SaleSalePriceCrossRef.cSalePriceCreatedAt}';
    // end column
    const String foreginKey = '$saleTableAlias.${SaleEntity.columnSalePriceId} = $salePriceTableAlias.${SalePriceEntity.columnId}';
    var query = '''SELECT $saleId,$name,$salePriceId,$amount,$liter,$saleCreatedAt,$priceId,$price,$salePriceCreatedAt 
              FROM ${SaleEntity.tableName} AS $saleTableAlias LEFT JOIN ${SalePriceEntity.tableName} AS $salePriceTableAlias
              ON $foreginKey''';
    if (date != null) {
      query = '''$query WHERE $saleTableAlias.${SaleEntity.columnCreatedAt} >= ${date.millisecondsSinceEpoch} 
              AND $saleTableAlias.${SaleEntity.columnCreatedAt} <= ${date.add(const Duration(days: 1)).millisecondsSinceEpoch}''';
    }
    var result = await _database.rawQuery(query);
    return result.map((e) => SaleSalePriceCrossRef.fromMap(e)).toList();
  }
}
