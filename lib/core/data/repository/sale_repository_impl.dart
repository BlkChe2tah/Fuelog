import 'package:meta/meta.dart';
import 'package:petrol_ledger/common/result.dart';
import 'package:petrol_ledger/core/data/model/sale.dart';
import 'package:petrol_ledger/core/data/repository/sale_repository.dart';
import 'package:petrol_ledger/core/database/data_holder.dart';
import 'package:petrol_ledger/core/database/models/sale_entity.dart';
import 'package:petrol_ledger/core/database/models/sale_sale_price_cross_ref.dart';

@sealed
class SaleRepositoryImpl implements SaleRepository {
  final DataHolder _dataHolder;
  SaleRepositoryImpl(DataHolder dataHolder) : _dataHolder = dataHolder;

  @override
  Future<void> deleteSales() async {
    _dataHolder.saleDAO.deleteSales();
  }

  @override
  Future<Result<List<Sale>>> getSales([DateTime? date]) async {
    try {
      final result = await _dataHolder.saleDAO.getSales(date);
      return Success(result.map((e) => e.toSaleUiModel()).toList());
    } catch (e) {
      return Error(Exception(e.toString()));
    }
  }

  @override
  Future<int> getSalesCount() async {
    return _dataHolder.saleDAO.getSalesCount();
  }

  @override
  Future<int> getSalesCountForOneDay(DateTime date) async {
    return _dataHolder.saleDAO.getSalesCountForOneDay(date);
  }

  @override
  Future<Result<bool>> addNewSale({String? name, required int salePriceId, required String amount, required String liter, required DateTime date}) async {
    try {
      final result = await _dataHolder.saleDAO.upsertSaleData(SaleEntity(
        name: name,
        amount: int.parse(amount),
        salePriceId: salePriceId,
        liter: double.parse(liter),
        createdAt: date.millisecondsSinceEpoch,
      ));
      if (result == 0) {
        return Error(Exception("$amount $liter cannot store"));
      }
      return Success(true);
    } catch (e) {
      return Error(Exception(e.toString()));
    }
  }
}
