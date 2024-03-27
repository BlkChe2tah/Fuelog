// import 'dart:async';
// import 'package:petrol_ledger/core/database/data_holder.dart';
// import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';
// import 'package:petrol_ledger/repository/sale_data/sale_data_repository.dart';

// class SaleDataRepositoryImpl implements SaleDataRepository {
//   final DataHolder _database;

//   SaleDataRepositoryImpl(DataHolder database) : _database = database;

//   @override
//   Future<SalePriceEntity?> queryLatestSalePrice() async {
//     try {
//       return _database.salePriceDAO.getLatestSalePrice();
//     } catch (e) {
//       throw Exception(e);
//     } finally {}
//   }
// }
