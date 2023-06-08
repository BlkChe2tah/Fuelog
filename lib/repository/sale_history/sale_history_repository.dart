import 'package:petrol_ledger/model/sale_item_data.dart';

abstract class SaleHistoryRepository {
  Future<List<SaleItemData>> loadSaleDataByDate(DateTime date);
  Future<void> deleteAllData();
}
