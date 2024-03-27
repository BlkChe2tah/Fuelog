import 'package:equatable/equatable.dart';

enum SalePriceStatus {
  initial,
  success,
  error
}

class SalePriceState extends Equatable {
  final SalePriceStatus status;
  final int priceId;
  final int price;

  const SalePriceState({required this.status, required this.price, required this.priceId});

  factory SalePriceState.initial() => const SalePriceState(status: SalePriceStatus.initial, priceId: 0, price: 0);

  factory SalePriceState.success(int priceId, int price) => SalePriceState(status: SalePriceStatus.success, priceId: priceId, price: price);

  factory SalePriceState.error() => const SalePriceState(status: SalePriceStatus.error, priceId: 0, price: 0);

  @override
  List<Object?> get props => [
        status,
        priceId
      ];
}
