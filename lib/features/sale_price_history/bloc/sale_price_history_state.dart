part of 'sale_price_history_bloc.dart';

class SalePriceHistoryState extends Equatable {
  final String price;
  final SalePriceState priceState;
  final UiState uiState;
  const SalePriceHistoryState({
    required this.price,
    required this.priceState,
    required this.uiState,
  });

  static final initial = SalePriceHistoryState(
    price: "0",
    priceState: const SalePriceState(priceId: 0, price: 0, status: SalePriceStatus.initial),
    uiState: InitialState(),
  );

  SalePriceHistoryState copyWith({
    String? price,
    SalePriceState? priceState,
    UiState? uiState,
  }) {
    return SalePriceHistoryState(
      price: price ?? this.price,
      priceState: priceState ?? this.priceState,
      uiState: uiState ?? this.uiState,
    );
  }

  @override
  List<Object> get props => [
        price,
        priceState,
        uiState,
      ];
}
