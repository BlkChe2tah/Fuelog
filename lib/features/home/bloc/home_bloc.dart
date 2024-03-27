import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petrol_ledger/common/key_controller.dart';
import 'package:petrol_ledger/common/result.dart';
import 'package:petrol_ledger/core/data/model/sale_price_state.dart';
import 'package:petrol_ledger/core/data/repository/latest_sale_price_repository.dart';
import 'package:petrol_ledger/core/data/repository/sale_repository.dart';
import 'package:petrol_ledger/common/ui_state.dart';
import 'package:petrol_ledger/features/home/model/sale_request_data.dart';
import 'package:petrol_ledger/core/ui/components/keypad_type_selector.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final KeyController _controller;
  final LatestSalePriceRepository _repository;
  final SaleRepository _saleRepository;

  late final StreamSubscription _salePriceSubscription;

  SalePriceState _salePriceState = SalePriceState.initial();

  HomeBloc({
    required KeyController controller,
    required LatestSalePriceRepository repository,
    required SaleRepository saleRepository,
  })  : _controller = controller,
        _repository = repository,
        _saleRepository = saleRepository,
        super(HomeState.initial) {
    on<_SalePriceChanged>(_salePriceChanged);
    on<ValueKeyPressed>(_valueKeyPressed);
    on<DeleteKeyPressed>(_deleteKeyPressed);
    on<KeypadTypeChanged>(_keypadTypeChanged);
    on<AddNewSalePrice>(_addNewSalePrice);
    on<AddNewSale>(_addNewSale);
    on<ResetUiState>(_resetUiState);
    _salePriceSubscription = _repository.latestSalePrice.listen((state) {
      _salePriceState = state;
      add(_SalePriceChanged(state: state));
    });
  }

  @override
  Future<void> close() {
    _salePriceSubscription.cancel();
    return super.close();
  }

  Future<void> _salePriceChanged(_SalePriceChanged event, Emitter<HomeState> emit) async {
    final salePrice = event.state.status == SalePriceStatus.success ? event.state.price : 0;
    emit(state.copyWith(
      price: salePrice.toString(),
      amount: "0",
      liter: "0",
      priceState: event.state.status,
    ));
  }

  Future<void> _valueKeyPressed(ValueKeyPressed event, Emitter<HomeState> emit) async {
    _controller.append(event.value, isZeroKey: event.isZeroKey);
    emit(state.copyWith(
      amount: state.keypadType == KeypadType.amount ? _controller.value : _calculateAmount(),
      liter: state.keypadType == KeypadType.liter ? _controller.value : _calculateLiter(),
    ));
  }

  Future<void> _deleteKeyPressed(DeleteKeyPressed event, Emitter<HomeState> emit) async {
    _controller.delete();
    emit(state.copyWith(
      amount: state.keypadType == KeypadType.amount ? _controller.value : _calculateAmount(),
      liter: state.keypadType == KeypadType.liter ? _controller.value : _calculateLiter(),
    ));
  }

  Future<void> _addNewSalePrice(AddNewSalePrice event, Emitter<HomeState> emit) async {
    await _repository.addNewSalePrice(event.price);
  }

  Future<void> _addNewSale(AddNewSale event, Emitter<HomeState> emit) async {
    emit(state.copyWith(uiState: LoadingState()));
    if (_salePriceState.status != SalePriceStatus.success) {
      emit(state.copyWith(uiState: ErrorState("Sale Price Empty")));
      return;
    }
    final result = await _saleRepository.addNewSale(
      salePriceId: _salePriceState.priceId,
      name: event.data.name,
      amount: event.data.amount,
      liter: event.data.liter,
      date: DateTime.now(),
    );
    if (result is Success) {
      _controller.reset();
      emit(state.copyWith(uiState: SuccessState("Record saved successfully"), liter: "0", amount: "0"));
    } else {
      emit(state.copyWith(uiState: ErrorState("Cannot store sale data")));
    }
  }

  Future<void> _keypadTypeChanged(KeypadTypeChanged event, Emitter<HomeState> emit) async {
    _controller.reset();
    emit(state.copyWith(
      keypadType: event.type,
      liter: "0",
      amount: "0",
    ));
  }

  Future<void> _resetUiState(ResetUiState event, Emitter<HomeState> emit) async {
    emit(state.copyWith(uiState: InitialState()));
  }

  String _calculateLiter() {
    final price = int.parse(state.price);
    if (price == 0) return "0";
    final amount = int.parse(_controller.value);
    return (amount / price).toStringAsFixed(2);
  }

  String _calculateAmount() {
    final price = int.parse(state.price);
    final liter = double.parse(_controller.value);
    return (price * liter).toStringAsFixed(0);
  }
}
