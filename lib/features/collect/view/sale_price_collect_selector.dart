import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/features/collect/domain/sale_price_collect_provider.dart';
import 'package:petrol_ledger/features/collect/view/sale_price_collect_screen.dart';
import 'package:petrol_ledger/core/utils/extension.dart';
import 'package:petrol_ledger/core/ui_state.dart';
import 'package:provider/provider.dart';

class SalePriceCollectSelector extends StatelessWidget {
  const SalePriceCollectSelector({super.key});

  bool _checkLoadingMode(BuildContext context) {
    return context.select<SalePriceCollectProvider, UiState>(
      (provider) => provider.uiState,
    ) is LoadingMode;
  }

  VoidCallback? _onDecreaseButtonClicked(BuildContext context) {
    var isLoadingMode = _checkLoadingMode(context);
    if (isLoadingMode) return null;
    return () {
      context.read<SalePriceCollectProvider>().decreaseSalePricebyOne();
    };
  }

  VoidCallback? _onIncreaseButtonClicked(BuildContext context) {
    var isLoadingMode = _checkLoadingMode(context);
    if (isLoadingMode) return null;
    return () {
      context.read<SalePriceCollectProvider>().increaseSalePricebyOne();
    };
  }

  Function(double)? _checkSliderState(BuildContext context) {
    var isLoadingMode = _checkLoadingMode(context);
    if (isLoadingMode) return null;
    return (value) {
      context.read<SalePriceCollectProvider>().setSalePrice(value);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: _onDecreaseButtonClicked(context),
          icon: const Icon(
            Symbols.arrow_circle_left,
            size: 28.0,
            weight: 300,
          ),
        ),
        Expanded(
          child: Theme(
            data: Theme.of(context).copyWith(
              sliderTheme: SliderThemeData(
                trackHeight: 1,
                inactiveTrackColor: context.loadColorScheme().outlineVariant,
              ),
            ),
            child: Slider(
              min: SalePriceCollectScreen.minAmount,
              max: SalePriceCollectScreen.maxAmount,
              value: context.select<SalePriceCollectProvider, double>(
                (provider) => provider.salePrice,
              ),
              onChanged: _checkSliderState(context),
            ),
          ),
        ),
        IconButton(
          onPressed: _onIncreaseButtonClicked(context),
          icon: const Icon(
            Symbols.arrow_circle_right,
            size: 28.0,
            weight: 300,
          ),
        ),
      ],
    );
  }
}
