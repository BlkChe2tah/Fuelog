import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petrol_ledger/common/result.dart';
import 'package:petrol_ledger/core/data/model/sale_price.dart';
import 'package:petrol_ledger/core/data/model/sale_price_state.dart';
import 'package:petrol_ledger/core/data/repository/latest_sale_price_repository.dart';
import 'package:petrol_ledger/core/data/repository/sale_price_repository.dart';
import 'package:petrol_ledger/core/domain/app_date_formatter.dart';
import 'package:petrol_ledger/core/domain/app_price_formatter.dart';
import 'package:petrol_ledger/common/ui_state.dart';

part 'sale_price_history_event.dart';
part 'sale_price_history_state.dart';

class SalePriceHistoryBloc extends Bloc<SalePriceHistoryEvent, SalePriceHistoryState> {
  final LatestSalePriceRepository _repository;
  final SalePriceRepository _salePriceRepository;
  final AppPriceFormatter _priceFormatter;
  final AppDateFormatter _dateFormatter;

  late final StreamSubscription _salePriceSubscription;

  SalePriceHistoryBloc({
    required LatestSalePriceRepository repository,
    required SalePriceRepository salePriceRepository,
    required AppPriceFormatter priceFormatter,
    required AppDateFormatter dateFormatter,
  })  : _repository = repository,
        _priceFormatter = priceFormatter,
        _dateFormatter = dateFormatter,
        _salePriceRepository = salePriceRepository,
        super(SalePriceHistoryState.initial) {
    on<AddNewSalePrice>(_addNewSalePrice);
    on<_SalePriceChanged>(_salePriceChanged);

    _salePriceSubscription = _repository.latestSalePrice.listen((state) {
      add(_SalePriceChanged(state: state));
    });
  }

  Future<void> _salePriceChanged(_SalePriceChanged event, Emitter<SalePriceHistoryState> emit) async {
    emit(state.copyWith(
      price: _priceFormatter.format(event.state.price.toDouble()),
      priceState: event.state,
      uiState: event.state.status == SalePriceStatus.error ? InitialState() : LoadingState(),
    ));
    if (event.state.status == SalePriceStatus.success) {
      final result = await _salePriceRepository.loadSalePrices();
      emit(state.copyWith(
        uiState: result is Success<List<SalePrice>>
            ? SuccessState(result.data.toSalePriceItemViewData(
                _priceFormatter,
                _dateFormatter,
                true,
              ))
            : ErrorState("Cannot load sale price"),
      ));
    }
  }

  Future<void> _addNewSalePrice(AddNewSalePrice event, Emitter<SalePriceHistoryState> emit) async {
    await _repository.addNewSalePrice(event.price);
  }

  @override
  Future<void> close() {
    _salePriceSubscription.cancel();
    return super.close();
  }
}
