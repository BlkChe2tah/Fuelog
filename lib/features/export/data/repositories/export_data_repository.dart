import 'package:petrol_ledger/model/sale_item_data.dart';

abstract class ExportDataRepository {
  Future<int> loadAllItemCount();
  Future<int> loadItemCountByDate(DateTime date);
  Stream<SaleItemData> queryAllDataAsStream();
  Stream<SaleItemData> queryDataByDateAsStream(DateTime date);
}
