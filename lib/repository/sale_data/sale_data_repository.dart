import 'package:petrol_ledger/model/sale_price.dart';

abstract class SaleDataRepository {
  Future<SalePrice> queryLatestSalePrice();
}
