part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class _SalePriceChanged extends HomeEvent {
  final SalePriceState state;
  const _SalePriceChanged({required this.state});
}

final class ValueKeyPressed extends HomeEvent {
  final String value;
  final bool isZeroKey;
  const ValueKeyPressed({required this.value, this.isZeroKey = false});

  @override
  List<Object> get props => [
        value,
        isZeroKey,
      ];
}

final class DeleteKeyPressed extends HomeEvent {
  const DeleteKeyPressed();
}

final class KeypadTypeChanged extends HomeEvent {
  final KeypadType type;
  const KeypadTypeChanged({required this.type});

  @override
  List<Object> get props => [
        type
      ];
}

final class AddNewSalePrice extends HomeEvent {
  final int price;
  const AddNewSalePrice({required this.price});

  @override
  List<Object> get props => [
        price
      ];
}

final class AddNewSale extends HomeEvent {
  final SaleRequestData data;
  const AddNewSale({required this.data});

  @override
  List<Object> get props => [
        data
      ];
}

final class ResetUiState extends HomeEvent {
  const ResetUiState();
}
