import 'package:petrol_ledger/core/database/sqlite_sale_database.dart';
import 'package:petrol_ledger/model/sale.dart';
import 'package:sqflite/sqflite.dart';
import 'package:petrol_ledger/repository/sale_data_collect/sale_data_collect_repository.dart';

class SQLiteSaleDataCollect implements SaleDataCollectRepository {
  final SQLiteSaleDatabase _database = SQLiteSaleDatabase.instance;

  @override
  Future<void> insert(Sale data) async {
    var db = await _database.open();
    try {
      var status = await db.insert(
        Sale.tableName,
        Sale.toMap(data),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (status == 0) {
        throw Exception('${data.amount} cannot store');
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      db.close();
    }
  }
}
