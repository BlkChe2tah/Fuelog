import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/component/close_btn.dart';
import 'package:petrol_ledger/provider/sale_price_collect_provider.dart';
import 'package:petrol_ledger/res/values.dart';
import 'package:petrol_ledger/screens/sale_price_collect/sale_price_collect_header.dart';
import 'package:petrol_ledger/screens/sale_price_collect/sale_price_collect_selector.dart';
import 'package:petrol_ledger/utils/extension.dart';
import 'package:petrol_ledger/utils/ui_state.dart';
import 'package:provider/provider.dart';

class SalePriceCollectContainer extends StatelessWidget {
  const SalePriceCollectContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: context.loadColorScheme().surfaceVariant,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(kXLarge),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: kLarge),
                const SalePriceCollectHeader(),
                const SizedBox(height: kXLarge),
                const SalePriceCollectSelector(),
                const SizedBox(height: kXLarge),
                const _SalePriceCollectSaveBtn(),
                Consumer<bool>(
                  builder: (context, showInfoView, child) {
                    return Visibility(
                      visible: showInfoView,
                      child: child!,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: kLarge),
                    child: _InfoView(),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 0.0,
            right: 0.0,
            child: CloseBtn(),
          ),
        ],
      ),
    );
  }
}

// submit button
class _SalePriceCollectSaveBtn extends StatelessWidget {
  const _SalePriceCollectSaveBtn();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kButtonSize,
      child: Selector<SalePriceCollectProvider, UiState>(
        selector: (_, provider) => provider.uiState,
        builder: (context, uiState, child) {
          if (uiState is LoadingMode) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return child!;
        },
        child: FilledButton(
          onPressed: () {
            context.read<SalePriceCollectProvider>().save();
          },
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
          ),
          child: Text(
            'OK',
            style: context.loadTextTheme().labelLarge?.copyWith(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}

class _InfoView extends StatelessWidget {
  const _InfoView();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Symbols.info,
          color: context.loadColorScheme().error,
          size: 20.0,
        ),
        const SizedBox(width: kSmall),
        Text(
          'Please specify the sale price first.',
          style: context.loadTextTheme().labelLarge?.copyWith(
                fontSize: 15.0,
                color: context.loadColorScheme().error,
              ),
        ),
      ],
    );
  }
}
