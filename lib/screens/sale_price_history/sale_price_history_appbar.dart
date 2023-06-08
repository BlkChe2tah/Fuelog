import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/model/sale_price_item_data.dart';
import 'package:petrol_ledger/provider/sale_data_provider.dart';
import 'package:petrol_ledger/provider/sale_price_history_provider.dart';
import 'package:petrol_ledger/res/values.dart';
import 'package:petrol_ledger/screens/sale_price_collect/sale_price_collect_screen.dart';
import 'package:petrol_ledger/utils/extension.dart';
import 'package:petrol_ledger/utils/ui_state.dart';
import 'package:provider/provider.dart';

class SalePriceHistoryAppbar extends SliverPersistentHeaderDelegate {
  final double topInset;
  final BuildContext context;
  SalePriceHistoryAppbar(this.context)
      : topInset = MediaQuery.of(context).viewPadding.top + kToolbarHeight;

  void _refreshPrice(BuildContext context) {
    context.read<SaleDataProvider>().loadLatestSalePrice();
    context.read<SalePriceHistoryProvider>().loadSalePrices();
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final diff = maxExtent - minExtent;
    return LayoutBuilder(
      builder: (_, constraint) {
        final progress = 1 - (maxExtent - constraint.maxHeight) / diff;
        return Container(
          color: context.loadColorScheme().background,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: topInset),
                  child: Column(
                    children: [
                      Selector<SalePriceHistoryProvider, UiState>(
                        selector: (_, provider) => provider.uiState,
                        builder: (context, uiState, child) {
                          final amount =
                              uiState is SuccessMode<List<SalePriceItemData>> &&
                                      uiState.result.isNotEmpty
                                  ? uiState.result.last.price
                                  : 0;
                          return RichText(
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '$amount',
                                  style: context
                                      .loadTextTheme()
                                      .displayLarge
                                      ?.copyWith(
                                        fontFamily: 'anonymous pro',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                      ),
                                ),
                                TextSpan(
                                  text: 'Ks',
                                  style: context.loadTextTheme().labelLarge,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Text(
                        'Current Sale Price',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: context.loadTextTheme().labelLarge?.copyWith(
                              color: context.loadColorScheme().onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedScale(
                  alignment: Alignment.bottomCenter,
                  scale: progress,
                  duration: Duration.zero,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: kLarge),
                    child: FilledButton.icon(
                      onPressed: () async {
                        bool? isSuccess = await context.showAlertDialog(
                          child: const SalePriceCollectScreen(),
                        );
                        if (isSuccess != null && isSuccess && context.mounted) {
                          _refreshPrice(context);
                        }
                      },
                      icon: const Icon(
                        Symbols.currency_exchange,
                        size: 22.0,
                      ),
                      label: Text(
                        'Change Sale Price',
                        style: context.loadTextTheme().labelLarge?.copyWith(
                              fontSize: 18.0,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Symbols.arrow_back_ios,
                    color: context.loadColorScheme().onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => topInset + 158;

  @override
  double get minExtent => topInset + 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
