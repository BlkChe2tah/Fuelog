import 'package:petrol_ledger/model/sale_price.dart';

abstract class SalePriceCollectRepository {
  Future<void> addSalePrice(SalePrice data);
}
