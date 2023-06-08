import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/provider/keypad_screen_provider.dart';
import 'package:petrol_ledger/res/values.dart';
import 'package:petrol_ledger/screens/amount_confirm/amount_confirm_screen.dart';
import 'package:petrol_ledger/screens/keypad/key_item.dart';
import 'package:petrol_ledger/screens/keypad/keypad_type_selector.dart';
import 'package:petrol_ledger/screens/sale_history/sale_history_screen.dart';
import 'package:petrol_ledger/screens/sale_price_history/sale_price_history_screen.dart';
import 'package:petrol_ledger/utils/extension.dart';
import 'package:provider/provider.dart';

class Keypad extends StatelessWidget {
  const Keypad({super.key});

  void _showAmountConfirmDialog(
      BuildContext context, KeypadScreenProvider provider) async {
    bool? result = await context.showAlertDialog(
      child: AmountConfirmScreen(
        saleLiter: double.parse(provider.liter),
        saleAmount: int.parse(provider.amount),
      ),
    );
    if (result != null && result) {
      provider.reset();
    }
  }

  VoidCallback? _onCheckButtonClicked(BuildContext context) {
    return () {
      var provider = context.read<KeypadScreenProvider>();
      if (provider.amount == KeypadScreenProvider.initValue) {
        context.showSnackBar("Oops! Sale amount can't be zero.");
        return;
      }
      _showAmountConfirmDialog(context, provider);
    };
  }

  VoidCallback? _navigateSaleHistoryScreen(BuildContext context) {
    return () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const SaleHistoryScreen();
          },
        ),
      );
    };
  }

  VoidCallback? _navigateSalePriceHistoryScreen(BuildContext context) {
    return () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const SalePriceHistoryScreen();
          },
        ),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Wrap(
            spacing: kKeyItemSpacing,
            runSpacing: kKeyItemSpacing,
            children: [
              KeyItem.number(context, '1'),
              KeyItem.number(context, '2'),
              KeyItem.number(context, '3'),
              KeyItem.number(context, '4'),
              KeyItem.number(context, '5'),
              KeyItem.number(context, '6'),
              KeyItem.number(context, '7'),
              KeyItem.number(context, '8'),
              KeyItem.number(context, '9'),
              Selector<KeypadScreenProvider, KeypadType>(
                selector: (_, provider) => provider.keypadType,
                builder: (context, keypadType, _) {
                  return KeyItem.number(
                    context,
                    keypadType == KeypadType.amount ? '00' : '.',
                  );
                },
              ),
              KeyItem.number(context, '0'),
              KeyItem.delete(context),
            ],
          ),
        ),
        Wrap(
          direction: Axis.vertical,
          spacing: kKeyItemSpacing,
          runSpacing: kKeyItemSpacing,
          children: [
            KeyItem.icon(
              context,
              Symbols.list_alt_rounded,
              onPress: _navigateSaleHistoryScreen(context),
              color: context.loadColorScheme().primary,
            ),
            KeyItem.icon(
              context,
              Symbols.price_change,
              onPress: _navigateSalePriceHistoryScreen(context),
              color: context.loadColorScheme().primary,
            ),
            KeyItem.icon(
              context,
              Symbols.done_rounded,
              onPress: _onCheckButtonClicked(context),
              backgroundColor: context.loadColorScheme().primary,
              doubleHeight: true,
            ),
          ],
        ),
      ],
    );
  }
}
