import 'package:meta/meta.dart';
import 'package:petrol_ledger/core/database/dao/sale_price_dao.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';

@sealed
class FakeSalePriceDAO implements SalePriceDAO {
  final List<SalePriceEntity> _salePrices = [];
  List<SalePriceEntity> get salePrices => _salePrices;

  void setupData(List<SalePriceEntity> data) {
    _salePrices.addAll(data);
  }

  void deleteAll() {
    _salePrices.clear();
  }

  @override
  Future<int> deleteSalePrices() {
    final rowsEffects = _salePrices.length;
    _salePrices.clear();
    return Future.value(rowsEffects);
  }

  @override
  Future<SalePriceEntity?> getLatestSalePrice() {
    return Future.value(_salePrices.lastOrNull);
  }

  @override
  Future<List<SalePriceEntity>> getSalePrices() {
    return Future.value(_salePrices);
  }

  @override
  Future<int> upsertSalePrice(SalePriceEntity salePrice) {
    try {
      final matchIndex = _salePrices.indexWhere((element) => element.id == salePrice.id);
      if (matchIndex == -1) {
        _salePrices.add(
          SalePriceEntity(
            id: salePrices.length + 1,
            price: salePrice.price,
            createdAt: salePrice.createdAt,
          ),
        );
      } else {
        _salePrices[matchIndex] = salePrice;
      }
      return Future.value(1);
    } catch (_) {
      return Future.value(0);
    }
  }
}
