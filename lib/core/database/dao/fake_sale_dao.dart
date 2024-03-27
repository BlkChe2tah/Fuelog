import 'package:meta/meta.dart';
import 'package:petrol_ledger/core/database/dao/sale_dao.dart';
import 'package:petrol_ledger/core/database/models/sale_entity.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';
import 'package:petrol_ledger/core/database/models/sale_sale_price_cross_ref.dart';

@sealed
class FakeSaleDAO implements SaleDAO {
  final List<SaleEntity> _sales = [];
  List<SaleEntity> get sales => _sales;

  final List<SalePriceEntity> _salePrices = [];

  void setupData(List<SalePriceEntity> salePrices, List<SaleEntity> sales) {
    _salePrices.addAll(salePrices);
    _sales.addAll(sales);
  }

  void deleteAll() {
    _salePrices.clear();
    _sales.clear();
  }

  @override
  Future<int> deleteSales() {
    final rowsEffects = _sales.length;
    _sales.clear();
    return Future.value(rowsEffects);
  }

  @override
  Future<List<SaleSalePriceCrossRef>> getSales([DateTime? date]) {
    final time = date?.millisecondsSinceEpoch;
    var result = _sales;
    if (time != null) {
      result = _sales.where((element) => element.createdAt >= time && element.createdAt <= time).toList();
    }
    return Future.value(result.map((e) {
      final salePrice = _salePrices.firstWhere((element) => element.id == e.salePriceId);
      return SaleSalePriceCrossRef(
        saleId: e.id ?? 0,
        salePriceId: e.salePriceId,
        amount: e.amount,
        liter: e.liter,
        saleCreatedAt: e.createdAt,
        priceId: salePrice.id ?? 0,
        salePrice: salePrice.price,
        salePriceCreatedAt: salePrice.createdAt,
      );
    }).toList());
  }

  @override
  Future<int> getSalesCount() {
    return Future.value(_sales.length);
  }

  @override
  Future<int> getSalesCountForOneDay(DateTime date) {
    final time = date.millisecondsSinceEpoch;
    final result = _sales.where((element) => element.createdAt >= time && element.createdAt <= time).toList();
    return Future.value(result.length);
  }

  @override
  Future<int> upsertSaleData(SaleEntity data) async {
    try {
      final matchIndex = _sales.indexWhere((element) => element.id == data.id);
      if (matchIndex == -1) {
        _sales.add(
          SaleEntity(
            id: _sales.length + 1,
            name: data.name,
            amount: data.amount,
            salePriceId: data.salePriceId,
            liter: data.liter,
            createdAt: data.createdAt,
          ),
        );
      } else {
        _sales[matchIndex] = data;
      }
      return Future.value(1);
    } catch (_) {
      return Future.value(0);
    }
  }
}
