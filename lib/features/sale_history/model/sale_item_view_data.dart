import 'package:equatable/equatable.dart';

class SaleItemViewData extends Equatable {
  final int id;
  final String date;
  final String amount;
  final String liter;
  final String salePrice;
  final String name;

  const SaleItemViewData({
    required this.id,
    required this.date,
    required this.amount,
    required this.liter,
    required this.salePrice,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id
      ];
}

extension SalesExt on List<SaleItemViewData> {
  Stream<List<dynamic>> toCSVData() async* {
    for (final e in this) {
      yield ([
        e.date,
        e.amount,
        e.liter,
        e.salePrice,
        e.name
      ]);
    }
  }
}
