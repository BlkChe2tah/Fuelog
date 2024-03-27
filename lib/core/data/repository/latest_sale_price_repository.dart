import 'dart:async';

import 'package:petrol_ledger/common/result.dart';
import 'package:petrol_ledger/core/data/model/sale_price.dart';
import 'package:petrol_ledger/core/data/model/sale_price_state.dart';
import 'package:petrol_ledger/core/data/repository/sale_price_repository.dart';
import 'package:rxdart/rxdart.dart';

class LatestSalePriceRepository {
  final SalePriceRepository _repository;

  final _salePriceController = BehaviorSubject<SalePriceState>.seeded(SalePriceState.initial());
  Stream<SalePriceState> get latestSalePrice => _salePriceController.asBroadcastStream();

  LatestSalePriceRepository(SalePriceRepository repository) : _repository = repository;

  void loadLatestSalePrice() async {
    final result = await _repository.loadLatestSalePrice();
    if (result is Success<SalePrice?> && result.data != null) {
      _salePriceController.add(SalePriceState.success(result.data!.id, result.data!.price));
    } else {
      _salePriceController.add(SalePriceState.error());
    }
  }

  Future<void> addNewSalePrice(int price) async {
    _salePriceController.add(SalePriceState.initial());
    final result = await _repository.addNewSalePrice(price: price, date: DateTime.now());
    if (result is Success) {
      loadLatestSalePrice();
    } else {
      _salePriceController.add(SalePriceState.error());
    }
  }

  void dispose() {
    _salePriceController.close();
  }
}
