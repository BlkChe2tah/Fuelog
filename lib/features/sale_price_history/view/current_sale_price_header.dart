import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/core/data/model/sale_price_state.dart';
import 'package:petrol_ledger/core/design_system/values.dart';
import 'package:petrol_ledger/core/ui/new_sale_price_content_layout.dart';
import 'package:petrol_ledger/features/sale_price_history/bloc/sale_price_history_bloc.dart';

class CurrentSalePriceHeader extends StatelessWidget {
  const CurrentSalePriceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: colorScheme.background,
      child: Column(
        children: [
          RichText(
            maxLines: 1,
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: context.select<SalePriceHistoryBloc, String>((bloc) => bloc.state.price),
                  style: textTheme.displayLarge?.copyWith(
                    fontFamily: 'anonymous pro',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                TextSpan(
                  text: 'Ks',
                  style: textTheme.labelLarge,
                ),
              ],
            ),
          ),
          Text(
            'Current Sale Price',
            maxLines: 1,
            textAlign: TextAlign.center,
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          FilledButton.icon(
            onPressed: () async {
              final initialPrice = context.read<SalePriceHistoryBloc>().state.priceState;
              final result = await _showNewSalePriceDialog(context, initialPrice.status == SalePriceStatus.success ? initialPrice.price : null);
              if (result != null && initialPrice.price != result && context.mounted) {
                context.read<SalePriceHistoryBloc>().add(AddNewSalePrice(price: result));
              }
            },
            icon: const Icon(
              Symbols.currency_exchange,
              size: 22.0,
            ),
            label: Text(
              'Change Sale Price',
              style: textTheme.labelLarge?.copyWith(
                fontSize: 18.0,
              ),
            ),
          ),
          const SizedBox(height: kLarge),
        ],
      ),
    );
  }

  Future<int?> _showNewSalePriceDialog(BuildContext context, int? initialPrice) {
    return showDialog<int?>(
      context: context,
      barrierColor: Theme.of(context).colorScheme.background.withOpacity(0.95),
      builder: (_) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.symmetric(horizontal: kLarge, vertical: kHuge),
          content: NewSalePriceContentLayout(latestSalePrice: initialPrice),
        );
      },
    );
  }
}
