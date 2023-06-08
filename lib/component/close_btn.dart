import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/res/values.dart';
import 'package:petrol_ledger/utils/extension.dart';

class CloseBtn extends StatelessWidget {
  const CloseBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(kMedium),
        child: Icon(
          Symbols.close,
          size: 26.0,
          weight: 300,
          color: context.loadColorScheme().onSurfaceVariant,
        ),
      ),
    );
  }
}
