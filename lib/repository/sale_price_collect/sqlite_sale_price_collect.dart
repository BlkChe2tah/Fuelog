import 'package:petrol_ledger/database/sqlite_sale_database.dart';
import 'package:petrol_ledger/model/sale_price.dart';
import 'package:petrol_ledger/repository/sale_price_collect/sale_price_collect_repository.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteSalePriceCollect implements SalePriceCollectRepository {
  final SQLiteSaleDatabase _database = SQLiteSaleDatabase.instance;

  @override
  Future<void> addSalePrice(SalePrice data) async {
    var db = await _database.open();
    try {
      if (data.price == 0) {
        throw Exception('Undefined value');
      }
      var status = await db.insert(
        SalePrice.tableName,
        SalePrice.toMap(data),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (status == 0) {
        throw Exception('${data.price} cannot store');
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      db.close();
    }
  }
}
