import 'package:petrol_ledger/core/database/sqlite_sale_database.dart';
import 'package:petrol_ledger/model/sale.dart';
import 'package:petrol_ledger/model/sale_item_data.dart';
import 'package:petrol_ledger/model/sale_price.dart';
import 'package:petrol_ledger/repository/sale_history/sale_history_repository.dart';
import 'package:petrol_ledger/core/sale_query.dart';

class SQLiteSaleHistory implements SaleHistoryRepository {
  final SQLiteSaleDatabase _database = SQLiteSaleDatabase.instance;

  @override
  Future<List<SaleItemData>> loadSaleDataByDate(DateTime date) async {
    var db = await _database.open();
    try {
      final List<Map<String, dynamic>> queryResponse =
          await db.rawQuery(SaleQuery.byDate(date));
      return queryResponse.map((e) => SaleItemData.fromMap(e)).toList();
    } catch (e) {
      throw Exception(e);
    } finally {
      db.close();
    }
  }

  @override
  Future<void> deleteAllData() async {
    var db = await _database.open();
    try {
      await db.delete(Sale.tableName);
      await db.delete(SalePrice.tableName);
    } catch (e) {
      throw Exception(e);
    } finally {
      db.close();
    }
  }
}
