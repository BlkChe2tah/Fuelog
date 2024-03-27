import 'package:petrol_ledger/core/database/dao/sale_dao.dart';
import 'package:petrol_ledger/core/database/dao/sale_price_dao.dart';

abstract class DataHolder {
  late final SalePriceDAO salePriceDAO;
  late final SaleDAO saleDAO;
}
