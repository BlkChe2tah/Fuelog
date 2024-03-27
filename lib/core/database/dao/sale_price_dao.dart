import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';

abstract class SalePriceDAO {
  Future<int> upsertSalePrice(SalePriceEntity salePrice);
  Future<SalePriceEntity?> getLatestSalePrice();
  Future<List<SalePriceEntity>> getSalePrices();
  Future<int> deleteSalePrices();
}
