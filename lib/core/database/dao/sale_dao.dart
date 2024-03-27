import 'package:petrol_ledger/core/database/models/sale_entity.dart';
import 'package:petrol_ledger/core/database/models/sale_sale_price_cross_ref.dart';

abstract class SaleDAO {
  Future<int> getSalesCount();
  Future<int> getSalesCountForOneDay(DateTime date);
  Future<int> upsertSaleData(SaleEntity data);
  Future<List<SaleSalePriceCrossRef>> getSales([DateTime? date]);
  Future<int> deleteSales();
}
