// import 'package:petrol_ledger/core/database/sqlite_sale_database.dart';
// import 'package:petrol_ledger/core/database/models/sale_sale_price_cross_ref.dart';
// import 'package:petrol_ledger/repository/sale_history/sale_history_repository.dart';

// class SaleHistoryRepositoryImpl implements SaleHistoryRepository {
//   final SQLiteSaleDatabase _database;
//   SaleHistoryRepositoryImpl(SQLiteSaleDatabase database) : _database = database;

//   @override
//   Future<List<SaleSalePriceCrossRef>> loadSaleDataByDate(DateTime date) async {
//     try {
//       return _database.saleDAO.getSales(date);
//     } catch (e) {
//       throw Exception(e);
//     } finally {}
//   }

//   @override
//   Future<void> deleteAllData() async {
//     try {
//       await _database.salePriceDAO.deleteSalePrices();
//       await _database.saleDAO.deleteSales();
//     } catch (e) {
//       throw Exception(e);
//     } finally {}
//   }
// }
