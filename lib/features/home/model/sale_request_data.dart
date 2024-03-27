import 'package:equatable/equatable.dart';

class SaleRequestData extends Equatable {
  final String liter;
  final String amount;
  final String? name;

  const SaleRequestData({
    required this.liter,
    required this.amount,
    this.name,
  });

  @override
  List<Object?> get props => [
        liter,
        amount,
        name
      ];
}
