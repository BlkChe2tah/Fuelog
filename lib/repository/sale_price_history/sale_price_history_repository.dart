import 'package:petrol_ledger/model/sale_price_item_data.dart';

abstract class SalePriceHistoryRepository {
  Future<List<SalePriceItemData>> loadSalePrices();
}
