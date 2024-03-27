part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String price;
  final String amount;
  final String liter;
  final KeypadType keypadType;
  final SalePriceStatus priceState;
  final UiState uiState;

  const HomeState({
    required this.price,
    required this.amount,
    required this.liter,
    required this.keypadType,
    required this.priceState,
    required this.uiState,
  });

  static final initial = HomeState(
    price: "0",
    amount: "0",
    liter: "0",
    keypadType: KeypadType.amount,
    priceState: SalePriceStatus.initial,
    uiState: InitialState(),
  );

  HomeState copyWith({
    String? price,
    String? amount,
    String? liter,
    KeypadType? keypadType,
    SalePriceStatus? priceState,
    UiState? uiState,
  }) {
    return HomeState(
      price: price ?? this.price,
      amount: amount ?? this.amount,
      liter: liter ?? this.liter,
      keypadType: keypadType ?? this.keypadType,
      priceState: priceState ?? this.priceState,
      uiState: uiState ?? this.uiState,
    );
  }

  @override
  List<Object> get props => [
        price,
        amount,
        liter,
        keypadType,
        priceState,
        uiState,
      ];
}
