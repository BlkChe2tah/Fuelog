import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:petrol_ledger/core/design_system/colors.dart';
import 'package:petrol_ledger/core/domain/app_date_formatter.dart';
import 'package:petrol_ledger/core/domain/app_price_formatter.dart';
import 'package:petrol_ledger/features/sale_price_history/model/sale_price_item_view_data.dart';

@sealed
class SalePrice extends Equatable {
  final int id;
  final int price;
  final DateTime createdAt;

  const SalePrice({required this.id, required this.price, required this.createdAt});

  @override
  List<Object?> get props => [
        id
      ];
}

extension SalePriceExt on List<SalePrice> {
  List<SalePriceItemViewData> toSalePriceItemViewData(
    AppPriceFormatter priceFormatter,
    AppDateFormatter dateFormatter,
    bool isReversed,
  ) {
    if (isEmpty) return [];
    int temp = first.price;
    final result = map((e) {
      final diffPrice = e.price - temp;
      temp = e.price;
      return SalePriceItemViewData(
        id: e.id,
        date: dateFormatter.format(e.createdAt),
        salePrice: priceFormatter.format(e.price.toDouble()),
        diffPrice: "${diffPrice == 0 || diffPrice.isNegative ? "" : "+"}${priceFormatter.format(diffPrice.toDouble())}",
        color: diffPrice == 0
            ? kPrimaryTextColor
            : diffPrice.isNegative
                ? kPriceDecreaseColor
                : kPriceIncreaseColor,
      );
    }).toList();
    return isReversed ? result.reversed.toList() : result;
  }
}
