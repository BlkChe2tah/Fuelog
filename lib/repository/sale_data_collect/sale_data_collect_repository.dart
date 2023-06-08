import 'package:petrol_ledger/model/sale.dart';

abstract class SaleDataCollectRepository {
  Future<void> insert(Sale data);
}
