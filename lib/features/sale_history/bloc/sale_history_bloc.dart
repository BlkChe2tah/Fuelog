import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petrol_ledger/common/result.dart';
import 'package:petrol_ledger/core/data/model/sale.dart';
import 'package:petrol_ledger/core/data/repository/sale_repository.dart';
import 'package:petrol_ledger/core/domain/app_date_formatter.dart';
import 'package:petrol_ledger/core/domain/app_price_formatter.dart';
import 'package:petrol_ledger/core/filte_storage/storage.dart';
import 'package:petrol_ledger/common/ui_state.dart';
import 'package:petrol_ledger/core/ui/sale_export_type_content_layout.dart';

part 'sale_history_event.dart';
part 'sale_history_state.dart';

class SaleHistoryBloc extends Bloc<SaleHistoryEvent, SaleHistoryState> {
  final SaleRepository _repository;
  final AppDateFormatter _formatter;
  final AppDateFormatter _hourFormatter;
  final AppPriceFormatter _priceFormatter;
  final Storage<File> _storage;

  bool get isEmptyRecord => state.allRecordCount == 0 && state.recordCountByDate == 0;

  SaleHistoryBloc({
    required SaleRepository repository,
    required AppDateFormatter formatter,
    required AppDateFormatter hourFormatter,
    required AppPriceFormatter priceFormatter,
    required DateTime initDate,
    required Storage<File> storage,
  })  : _repository = repository,
        _formatter = formatter,
        _hourFormatter = hourFormatter,
        _priceFormatter = priceFormatter,
        _storage = storage,
        super(SaleHistoryState(currentSelectedDate: initDate, date: formatter.format(initDate), uiState: InitialState(), allRecordCount: 0, recordCountByDate: 0)) {
    on<LoadAllSalesRecordByDate>(_loadAllSalesRecordByDate);
    on<ExportSaleRecord>(_exportSaleRecord);
    on<_Inialized>(_inializedBolc);
    add(_Inialized(initDate));
  }

  Future<void> _inializedBolc(_Inialized event, Emitter<SaleHistoryState> emit) async {
    try {
      emit(state.copyWith(uiState: LoadingState()));
      final resultAll = await _repository.getSalesCount();
      final result = await _repository.getSalesCountForOneDay(event.date);
      emit(state.copyWith(allRecordCount: resultAll, recordCountByDate: result));
      add(LoadAllSalesRecordByDate(event.date));
    } catch (e) {
      emit(state.copyWith(uiState: ErrorState("Empty sales record"), allRecordCount: 0, recordCountByDate: 0));
    }
  }

  Future<void> _loadAllSalesRecordByDate(LoadAllSalesRecordByDate event, Emitter<SaleHistoryState> emit) async {
    emit(state.copyWith(currentSelectedDate: event.date, date: _formatter.format(event.date), uiState: LoadingState()));
    final tempDate = event.date;
    final result = await _repository.getSales(DateTime(tempDate.year, tempDate.month, tempDate.day));
    if (result is Success<List<Sale>>) {
      emit(state.copyWith(
        recordCountByDate: result.data.length,
        uiState: SuccessState(result.data.map((e) => e.toItemViewData(_hourFormatter, _priceFormatter)).toList()),
      ));
    } else {
      emit(state.copyWith(uiState: ErrorState("Empty sales record"), recordCountByDate: 0));
    }
  }

  Future<void> _exportSaleRecord(ExportSaleRecord event, Emitter<SaleHistoryState> emit) async {
    // TODO export sale record
    // if (event.type == ExportType.date && state.recordCountByDate == 0) {
    //   emit(state.copyWith());
    //   return;
    // }
    // final externalDir = await getExternalStorageDirectory();
    // final csvPath = '${externalDir!.path}/CSV/${DateTime.now().millisecondsSinceEpoch}.csv';

    // final file = File(csvPath);
    // String csvContent = ListToCsvConverter().convert(data);

    // await file.writeAsString(csvContent);

    // print('CSV file saved to: $csvPath');
  }
}
