import 'dart:async';

import 'package:meta/meta.dart';
import 'package:petrol_ledger/common/result.dart';
import 'package:petrol_ledger/core/data/model/sale_price.dart';
import 'package:petrol_ledger/core/data/repository/sale_price_repository.dart';
import 'package:petrol_ledger/core/database/data_holder.dart';
import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';

@sealed
class SalePriceRepositoryImpl implements SalePriceRepository {
  final DataHolder _dataHolder;
  SalePriceRepositoryImpl(DataHolder dataHolder) : _dataHolder = dataHolder;

  @override
  Future<Result<int>> addNewSalePrice({required int price, required DateTime date}) async {
    try {
      final result = await _dataHolder.salePriceDAO.upsertSalePrice(SalePriceEntity(price: price, createdAt: date.millisecondsSinceEpoch));
      if (result == 0) {
        return Error(Exception("$price cannot store"));
      }
      return Success(price);
    } catch (e) {
      return Error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<bool>> deleteSalePrices() async {
    try {
      await _dataHolder.salePriceDAO.deleteSalePrices();
      return Success(true);
    } catch (e) {
      return Error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<SalePrice?>> loadLatestSalePrice() async {
    try {
      final result = await _dataHolder.salePriceDAO.getLatestSalePrice();
      return Success(result?.toUiModel());
    } catch (e) {
      return Error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<SalePrice>>> loadSalePrices() async {
    try {
      final result = await _dataHolder.salePriceDAO.getSalePrices();
      return Success(result.map((e) => e.toUiModel()).toList());
    } catch (e) {
      return Error(Exception(e.toString()));
    }
  }
}
