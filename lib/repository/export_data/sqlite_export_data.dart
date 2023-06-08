import 'package:petrol_ledger/database/sqlite_sale_database.dart';
import 'package:petrol_ledger/model/sale.dart';
import 'package:petrol_ledger/model/sale_item_data.dart';
import 'package:petrol_ledger/repository/export_data/export_data_repository.dart';
import 'package:petrol_ledger/utils/sale_query.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteExportData implements ExportDataRepository {
  final SQLiteSaleDatabase _database = SQLiteSaleDatabase.instance;

  @override
  Future<int> loadAllItemCount() async {
    var db = await _database.open();
    try {
      final List<Map<String, dynamic>> queryResponse =
          await db.rawQuery('SELECT COUNT(*) AS count FROM ${Sale.tableName}');
      return queryResponse.first['count'];
    } catch (e) {
      throw Exception(e);
    } finally {
      db.close();
    }
  }

  @override
  Future<int> loadItemCountByDate(DateTime date) async {
    var db = await _database.open();
    try {
      final List<Map<String, dynamic>> queryResponse = await db.rawQuery(
          'SELECT COUNT(*) AS count FROM ${Sale.tableName} WHERE ${SaleQuery.getDateFilter(date)}');
      return queryResponse.first['count'];
    } catch (e) {
      throw Exception(e);
    } finally {
      db.close();
    }
  }

  @override
  Stream<SaleItemData> queryAllDataAsStream() async* {
    var db = await _database.open();
    try {
      final QueryCursor cursor = await db.rawQueryCursor(SaleQuery.all(), null);
      while (await cursor.moveNext()) {
        yield SaleItemData.fromMap(cursor.current);
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      db.close();
    }
  }

  @override
  Stream<SaleItemData> queryDataByDateAsStream(DateTime date) async* {
    var db = await _database.open();
    try {
      final QueryCursor cursor =
          await db.rawQueryCursor(SaleQuery.byDate(date), null);
      while (await cursor.moveNext()) {
        yield SaleItemData.fromMap(cursor.current);
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      db.close();
    }
  }
}
