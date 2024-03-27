import 'package:petrol_ledger/common/result.dart';
import 'package:petrol_ledger/core/data/model/sale.dart';

abstract class SaleRepository {
  Future<int> getSalesCount();
  Future<int> getSalesCountForOneDay(DateTime date);
  Future<Result<bool>> addNewSale({String? name, required int salePriceId, required String amount, required String liter, required DateTime date});
  Future<Result<List<Sale>>> getSales([DateTime? date]);
  Future<void> deleteSales();
}
