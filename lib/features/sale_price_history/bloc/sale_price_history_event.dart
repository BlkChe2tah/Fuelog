part of 'sale_price_history_bloc.dart';

sealed class SalePriceHistoryEvent extends Equatable {
  const SalePriceHistoryEvent();
  @override
  List<Object> get props => [];
}

final class AddNewSalePrice extends SalePriceHistoryEvent {
  final int price;
  const AddNewSalePrice({required this.price});

  @override
  List<Object> get props => [
        price
      ];
}

final class _SalePriceChanged extends SalePriceHistoryEvent {
  final SalePriceState state;
  const _SalePriceChanged({required this.state});
}
