import 'dart:io';

import 'package:csv/csv.dart';
import 'package:get_it/get_it.dart';
import 'package:petrol_ledger/common/key_controller.dart';
import 'package:petrol_ledger/core/data/repository/latest_sale_price_repository.dart';
import 'package:petrol_ledger/core/data/repository/sale_price_repository.dart';
import 'package:petrol_ledger/core/data/repository/sale_price_repository_impl.dart';
import 'package:petrol_ledger/core/data/repository/sale_repository.dart';
import 'package:petrol_ledger/core/data/repository/sale_repository_impl.dart';
import 'package:petrol_ledger/core/database/dao/sale_dao.dart';
import 'package:petrol_ledger/core/database/dao/sale_dao_impl.dart';
import 'package:petrol_ledger/core/database/dao/sale_price_dao.dart';
import 'package:petrol_ledger/core/database/dao/sale_price_dao_impl.dart';
import 'package:petrol_ledger/core/database/data_holder.dart';
import 'package:petrol_ledger/core/database/sqlite_sale_database.dart';
import 'package:petrol_ledger/core/domain/app_date_formatter.dart';
import 'package:petrol_ledger/core/domain/app_price_formatter.dart';
import 'package:petrol_ledger/core/filte_storage/file_storage.dart';
import 'package:petrol_ledger/core/filte_storage/storage.dart';
import 'package:petrol_ledger/features/home/bloc/home_bloc.dart';
import 'package:petrol_ledger/features/sale_history/bloc/sale_history_bloc.dart';
import 'package:petrol_ledger/features/sale_price_history/bloc/sale_price_history_bloc.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

GetIt $sl = GetIt.instance;

Future<void> init() async {
  // bloc
  $sl.registerFactory(() => SalePriceHistoryBloc(
        repository: $sl(),
        salePriceRepository: $sl(),
        priceFormatter: $sl(instanceName: "without_symbol"),
        dateFormatter: $sl(instanceName: "y_mmmm_d_formatter"),
      ));
  $sl.registerFactory(() => HomeBloc(controller: $sl(), repository: $sl(), saleRepository: $sl()));
  $sl.registerFactory(() => SaleHistoryBloc(
        repository: $sl(),
        formatter: $sl(instanceName: 'mmmm_d_formatter'),
        hourFormatter: $sl(instanceName: 'h_m_formatter'),
        priceFormatter: $sl(instanceName: "with_symbol"),
        initDate: DateTime.now(),
        storage: $sl(),
      ));
  // CORE
  // common
  $sl.registerFactory<KeyController>(() => KeyController());
  $sl.registerLazySingleton<AppDateFormatter>(() => HmFormatter(), instanceName: 'h_m_formatter');
  $sl.registerLazySingleton<AppDateFormatter>(() => MMMMDFormatter(), instanceName: 'mmmm_d_formatter');
  $sl.registerLazySingleton<AppDateFormatter>(() => YMMMMDFormatter(), instanceName: 'y_mmmm_d_formatter');
  $sl.registerLazySingleton<AppPriceFormatter>(() => MMKPriceFormatter(), instanceName: "without_symbol");
  $sl.registerLazySingleton<AppPriceFormatter>(() => MMKPriceWithSymbolFormatter(), instanceName: "with_symbol");
  // repository
  $sl.registerLazySingleton<SaleRepository>(() => SaleRepositoryImpl($sl()));
  $sl.registerLazySingleton<SalePriceRepository>(() => SalePriceRepositoryImpl($sl()));
  $sl.registerLazySingleton<LatestSalePriceRepository>(() {
    final repo = LatestSalePriceRepository($sl());
    repo.loadLatestSalePrice();
    return repo;
  }, dispose: (provider) => provider.dispose());
  // dao
  $sl.registerLazySingleton<SaleDAO>(() => SaleDAOImpl($sl()));
  $sl.registerLazySingleton<SalePriceDAO>(() => SalePriceDAOImpl($sl()));
  // database
  $sl.registerLazySingleton<DataHolder>(() => SQLiteSaleDatabase($sl()));
  // storage
  $sl.registerFactory<Storage<File>>(() => FileStorage());
  // external resources
  $sl.registerLazySingleton(() => const ListToCsvConverter());
  $sl.registerSingletonAsync<sqlite.Database>(() async {
    try {
      final dbPath = Platform.isAndroid ? await sqlite.getDatabasesPath() : (await getLibraryDirectory()).path;
      return sqlite.openDatabase(
        p.join(dbPath, SQLiteSaleDatabase.name),
        onCreate: (db, version) async {
          var batch = db.batch();
          batch.execute(SQLiteSaleDatabase.createSalePriceTableScheme());
          batch.execute(SQLiteSaleDatabase.createSaleTableScheme());
          await batch.commit();
        },
        version: 1,
      );
    } catch (e) {
      throw Exception('${SQLiteSaleDatabase.name} cannot open');
    }
  });
}
