import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:petrol_ledger/core/domain/app_date_formatter.dart';
import 'package:petrol_ledger/core/domain/app_price_formatter.dart';
import 'package:petrol_ledger/features/sale_history/model/sale_item_view_data.dart';

@sealed
class Sale extends Equatable {
  final int saleId;
  final int salePriceId;
  final String? name;
  final int amount;
  final num liter;
  final int salePrice;
  final DateTime date;

  const Sale({
    required this.saleId,
    required this.salePriceId,
    required this.name,
    required this.amount,
    required this.liter,
    required this.salePrice,
    required this.date,
  });

  @override
  List<Object?> get props => [
        saleId,
        salePriceId,
        salePrice,
      ];
}

extension SaleExt on Sale {
  SaleItemViewData toItemViewData(AppDateFormatter formatter, AppPriceFormatter priceFormatter) {
    return SaleItemViewData(
      id: saleId,
      date: formatter.format(date),
      amount: priceFormatter.format(amount.toDouble()),
      liter: liter.toString(),
      salePrice: priceFormatter.format(salePrice.toDouble()),
      name: name?.toString() ?? "",
    );
  }
}
