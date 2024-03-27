import 'package:petrol_ledger/common/result.dart';
import 'package:petrol_ledger/core/data/model/sale_price.dart';

abstract class SalePriceRepository {
  Future<Result<int>> addNewSalePrice({required int price, required DateTime date});
  Future<Result<SalePrice?>> loadLatestSalePrice();
  Future<Result<List<SalePrice>>> loadSalePrices();
  Future<Result<bool>> deleteSalePrices();
}
