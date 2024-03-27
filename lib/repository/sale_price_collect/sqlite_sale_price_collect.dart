// import 'package:petrol_ledger/core/database/models/sale_price_entity.dart';
// import 'package:petrol_ledger/core/database/sqlite_sale_database.dart';
// import 'package:petrol_ledger/repository/sale_price_collect/sale_price_collect_repository.dart';

// class SalePriceCollectRepositoryImpl implements SalePriceCollectRepository {
//   final SQLiteSaleDatabase _database;

//   SalePriceCollectRepositoryImpl(SQLiteSaleDatabase database) : _database = database;

//   @override
//   Future<void> addNewSalePrice(SalePriceEntity salePrice) async {
//     try {
//       var result = await _database.salePriceDAO.upsertSalePrice(salePrice);
//       if (result == 0) {
//         throw Exception('New sale price ${salePrice.price} cannot store');
//       }
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
// }
