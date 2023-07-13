import 'dart:async';
import 'package:petrol_ledger/core/database/sqlite_sale_database.dart';
import 'package:petrol_ledger/model/sale_price.dart';
import 'package:petrol_ledger/repository/sale_data/sale_data_repository.dart';

class SQLiteSaleData implements SaleDataRepository {
  final SQLiteSaleDatabase database = SQLiteSaleDatabase.instance;

  @override
  Future<SalePrice> queryLatestSalePrice() async {
    var db = await database.open();
    try {
      final List<Map<String, dynamic>> data = await db.query(
        SalePrice.tableName,
        orderBy: '${SalePrice.columnCreatedAt} desc',
        limit: 1,
      );
      if (data.isEmpty) {
        throw Exception("Coludn't load sale price");
      }
      return SalePrice.fromMap(data.first);
    } catch (e) {
      throw Exception(e);
    } finally {
      db.close();
    }
  }
}
