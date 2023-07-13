import 'package:flutter/material.dart';
import 'package:petrol_ledger/features/keypad/domain/keypad_screen_provider.dart';
import 'package:petrol_ledger/core/provider/sale_data_provider.dart';
import 'package:petrol_ledger/core/values.dart';
import 'package:petrol_ledger/features/keypad/views/widgets/keypad_display_item.dart';
import 'package:petrol_ledger/features/keypad/views/widgets/keypad_type_selector.dart';
import 'package:petrol_ledger/core/utils/extension.dart';
import 'package:petrol_ledger/core/ui_state.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class KeypadDisplay extends StatelessWidget {
  const KeypadDisplay({super.key});

  String _checkSalePriceValue(UiState saleDataState) {
    if (saleDataState is SuccessMode) {
      return saleDataState.result as String;
    } else if (saleDataState is ErrorMode) {
      return String.fromCharCode(0216);
    } else {
      return "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        _DisplayContainer(
          child: Column(
            children: [
              KeypadTypeSelector(onChanged: (type) {
                context.read<KeypadScreenProvider>().setKeypadType(type.first);
              }),
              const Spacer(),
              Selector<SaleDataProvider, UiState>(
                selector: (_, provider) => provider.uiState,
                builder: (context, uiState, child) {
                  return KeypadDisplayItem.animate(
                    label: 'Price',
                    value: _checkSalePriceValue(uiState),
                    isAnimated: uiState is LoadingMode,
                  );
                },
              ),
              const Spacer(),
              Selector<KeypadScreenProvider, Tuple2<String, KeypadType>>(
                selector: (_, provider) =>
                    Tuple2(provider.liter, provider.keypadType),
                builder: (context, value, child) {
                  return KeypadDisplayItem(
                    label: 'Liter',
                    value: value.item1,
                    enable: value.item2 == KeypadType.liter,
                  );
                },
              ),
              const Spacer(),
              Selector<KeypadScreenProvider, Tuple2<String, KeypadType>>(
                selector: (_, provider) =>
                    Tuple2(provider.amount, provider.keypadType),
                builder: (context, value, child) {
                  return KeypadDisplayItem(
                    label: 'Amount',
                    value: value.item1,
                    enable: value.item2 == KeypadType.amount,
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
        Selector<SaleDataProvider, UiState>(
          selector: (_, provider) => provider.uiState,
          builder: (context, uiState, child) {
            return AnimatedSize(
              duration: const Duration(milliseconds: 150),
              child: Visibility(
                visible: uiState is ErrorMode,
                child: Container(
                  padding: const EdgeInsets.all(kMedium),
                  width: double.infinity,
                  color: context.loadColorScheme().error,
                  child: Text(
                    "Couldn't find the sale price. Please specify the price first.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.loadTextTheme().labelLarge?.copyWith(
                          fontSize: 16.0,
                          color: context.loadColorScheme().onError,
                        ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _DisplayContainer extends StatelessWidget {
  final Widget child;
  const _DisplayContainer({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kBodyPadding),
      child: child,
    );
  }
}
