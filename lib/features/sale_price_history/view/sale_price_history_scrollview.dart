import 'package:flutter/material.dart';
import 'package:petrol_ledger/model/sale_price_item_data.dart';
import 'package:petrol_ledger/features/sale_price_update/domain/sale_price_history_provider.dart';
import 'package:petrol_ledger/core/values.dart';
import 'package:petrol_ledger/features/sale_price_history/view/sale_price_history_appbar.dart';
import 'package:petrol_ledger/features/sale_price_history/view/sale_price_history_item_card.dart';
import 'package:petrol_ledger/core/utils/extension.dart';
import 'package:petrol_ledger/core/ui_state.dart';
import 'package:provider/provider.dart';

class SalePriceHistoryScrollView extends StatelessWidget {
  const SalePriceHistoryScrollView({super.key});

  Widget _loadSliverHeader(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SalePriceHistoryAppbar(context),
    );
  }

  Widget _loadSliverList(List<SalePriceItemData> items) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: items.length,
        (context, index) => SalePriceHistoryItemCard(data: items[index]),
      ),
    );
  }

  Widget _loadInfoView(BuildContext context, String message) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(kBorderRadius),
            topRight: Radius.circular(kBorderRadius),
          ),
          color: context.loadColorScheme().surface,
        ),
        child: Center(
          child: Text(message),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<SalePriceHistoryProvider, UiState>(
      selector: (_, provider) => provider.uiState,
      builder: (context, uiState, child) {
        var sliverItems = [_loadSliverHeader(context)];
        if (uiState is SuccessMode) {
          sliverItems
              .add(_loadSliverList(uiState.result as List<SalePriceItemData>));
          sliverItems.add(
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: kXLarge),
            ),
          );
        }
        if (uiState is EmptyMode) {
          sliverItems.add(_loadInfoView(context, "No Data"));
        }
        if (uiState is ErrorMode) {
          sliverItems.add(_loadInfoView(context, uiState.message));
        }
        var scrollState = uiState is SuccessMode
            ? const ClampingScrollPhysics()
            : const NeverScrollableScrollPhysics();
        return CustomScrollView(
          physics: scrollState,
          slivers: sliverItems,
        );
      },
    );
  }
}
