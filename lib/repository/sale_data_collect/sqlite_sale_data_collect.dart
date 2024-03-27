// import 'package:petrol_ledger/core/database/data_holder.dart';
// import 'package:petrol_ledger/core/database/models/sale_entity.dart';
// import 'package:petrol_ledger/repository/sale_data_collect/sale_data_collect_repository.dart';

// class SaleDataCollectRepositoryImpl implements SaleDataCollectRepository {
//   final DataHolder _database;
//   SaleDataCollectRepositoryImpl(DataHolder database) : _database = database;

//   @override
//   Future<void> addNewSale(SaleEntity data) async {
//     try {
//       var result = await _database.saleDAO.upsertSaleData(data);
//       if (result == 0) {
//         throw Exception('${data.amount} cannot store');
//       }
//     } catch (e) {
//       throw Exception(e);
//     } finally {}
//   }
// }
