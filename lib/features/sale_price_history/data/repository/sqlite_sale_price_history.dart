import 'package:petrol_ledger/core/database/sqlite_sale_database.dart';
import 'package:petrol_ledger/model/sale_price.dart';
import 'package:petrol_ledger/model/sale_price_item_data.dart';
import 'package:petrol_ledger/features/sale_price_history/data/repository/sale_price_history_repository.dart';

class SQLiteSalePriceHistory implements SalePriceHistoryRepository {
  final SQLiteSaleDatabase database = SQLiteSaleDatabase.instance;

  @override
  Future<List<SalePriceItemData>> loadSalePrices() async {
    var db = await database.open();
    try {
      final List<Map<String, dynamic>> data =
          await db.query(SalePrice.tableName);
      return _convertSalePriceItemData(data);
    } catch (e) {
      throw Exception(e);
    } finally {
      db.close();
    }
  }

  List<SalePriceItemData> _convertSalePriceItemData(
      List<Map<String, dynamic>> responseData) {
    int tempPrice = 0;
    List<SalePriceItemData> result = [];
    for (var i = 0; i < responseData.length; i++) {
      var tempItem = SalePrice.fromMap(responseData[i]);
      var date = DateTime.fromMillisecondsSinceEpoch(tempItem.createdAt);
      var diffPrice = tempPrice == 0 ? 0 : (tempItem.price - tempPrice);
      result.add(
        SalePriceItemData(
          date: '${date.day}/${date.month}/${date.year}',
          price: tempItem.price.toString(),
          diffPrice: diffPrice.abs().toString(),
          isIncreased: diffPrice > 0,
        ),
      );
      tempPrice = tempItem.price;
    }
    return result;
  }
}
