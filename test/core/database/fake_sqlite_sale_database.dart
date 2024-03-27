import 'package:mockito/mockito.dart';
import 'package:petrol_ledger/core/database/dao/fake_sale_dao.dart';
import 'package:petrol_ledger/core/database/dao/fake_sale_price_dao.dart';
import 'package:petrol_ledger/core/database/sqlite_sale_database.dart';

class FakeSQLiteSaleDatabase extends Fake implements SQLiteSaleDatabase {
  @override
  late final FakeSalePriceDAO salePriceDAO = FakeSalePriceDAO();

  @override
  late final FakeSaleDAO saleDAO = FakeSaleDAO();
}
