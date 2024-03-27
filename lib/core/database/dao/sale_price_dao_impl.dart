import 'package:meta/meta.dart';
import 'package:petrol_ledger/core/database/dao/sale_price_dao.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';
import 'package:sqflite/sqflite.dart';

@sealed
class SalePriceDAOImpl implements SalePriceDAO {
  final Database _database;
  SalePriceDAOImpl(Database database) : _database = database;

  @override
  Future<int> upsertSalePrice(SalePriceEntity salePrice) async {
    return _database.insert(SalePriceEntity.tableName, salePrice.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<SalePriceEntity?> getLatestSalePrice() async {
    final result = await _database.query(
      SalePriceEntity.tableName,
      orderBy: '${SalePriceEntity.columnCreatedAt} desc',
      limit: 1,
    );
    if (result.isNotEmpty) {
      return SalePriceEntity.fromMap(result.first);
    }
    return null;
  }

  @override
  Future<List<SalePriceEntity>> getSalePrices() async {
    final result = await _database.query(SalePriceEntity.tableName);
    return result.map((e) => SalePriceEntity.fromMap(e)).toList();
  }

  @override
  Future<int> deleteSalePrices() {
    return _database.delete(SalePriceEntity.tableName);
  }
}
