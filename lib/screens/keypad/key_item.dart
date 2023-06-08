import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/provider/keypad_screen_provider.dart';
import 'package:petrol_ledger/provider/sale_data_provider.dart';
import 'package:petrol_ledger/res/values.dart';
import 'package:petrol_ledger/screens/sale_price_collect/sale_price_collect_screen.dart';
import 'package:petrol_ledger/utils/extension.dart';
import 'package:petrol_ledger/utils/keys.dart';
import 'package:provider/provider.dart';

class KeyItem extends StatelessWidget {
  final Widget child;
  final Color? color;
  final VoidCallback? onPressed;
  final bool isDoubleHeight;

  const KeyItem._({
    required this.child,
    this.color,
    this.onPressed,
    this.isDoubleHeight = false,
  });

  factory KeyItem.number(BuildContext context, String key) {
    return KeyItem._(
      onPressed: _emitKey(context, type: Keys.numbers, key: key),
      child: Text(
        key,
        maxLines: 1,
        style: context.loadTextTheme().displaySmall?.copyWith(
              fontSize: 28.0,
              fontWeight: FontWeight.w100,
            ),
      ),
    );
  }

  factory KeyItem.delete(BuildContext context) {
    return KeyItem._(
      onPressed: _emitKey(context, type: Keys.delete, key: null),
      child: Icon(
        Symbols.backspace_rounded,
        size: 34.0,
        weight: 200,
        color: context.loadColorScheme().onSurface,
      ),
    );
  }

  factory KeyItem.icon(BuildContext context, IconData icon,
      {VoidCallback? onPress,
      Color? color,
      Color? backgroundColor,
      bool doubleHeight = false}) {
    return KeyItem._(
      onPressed: onPress,
      color: backgroundColor,
      isDoubleHeight: doubleHeight,
      child: Icon(
        icon,
        size: 34.0,
        weight: 200,
        color: color ?? context.loadColorScheme().onSurface,
      ),
    );
  }

  static void _showSalePriceRequestDialog(
      BuildContext context, SaleDataProvider provider) async {
    bool? result = await context.showAlertDialog(
      child: const SalePriceCollectScreen(showInfoView: true),
    );
    if (result != null && result && context.mounted) {
      provider.loadLatestSalePrice();
    }
  }

  static VoidCallback? _emitKey(BuildContext context,
      {required Keys type, String? key}) {
    return () {
      var saleDataProvider = context.read<SaleDataProvider>();
      if (saleDataProvider.salePriceId == 0) {
        _showSalePriceRequestDialog(context, saleDataProvider);
        return;
      }
      context.read<KeypadScreenProvider>().emit(
            salePrice: int.parse(saleDataProvider.salePrice),
            key: type,
            value: key,
          );
    };
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: context.loadColorScheme().surfaceVariant.withAlpha(130),
      child: Consumer<double>(
        builder: (_, value, __) {
          return Ink(
            width: value,
            height: isDoubleHeight ? value * 2 + kKeyItemSpacing : value,
            color: color ?? context.loadColorScheme().surface,
            child: Align(
              alignment: Alignment.center,
              child: child,
            ),
          );
        },
      ),
    );
  }
}
