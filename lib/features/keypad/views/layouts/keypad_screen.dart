import 'package:flutter/material.dart';
import 'package:petrol_ledger/core/values.dart';
import 'package:petrol_ledger/features/keypad/views/layouts/keypad_display.dart';
import 'package:petrol_ledger/features/keypad/views/layouts/keypad.dart';
import 'package:petrol_ledger/features/keypad/domain/keypad_screen_provider.dart';
import 'package:provider/provider.dart';

class KeypadScreen extends StatelessWidget {
  const KeypadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var keySize = ValueNotifier<double>(0.0);
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => KeypadScreenProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              const Expanded(child: KeypadDisplay()),
              LayoutBuilder(
                builder: (_, constraint) {
                  keySize.value =
                      (constraint.maxWidth - (kKeyItemSpacing * 3)) / 4;
                  return ValueListenableProvider.value(
                    value: keySize,
                    updateShouldNotify: (previous, current) =>
                        current > 0 && previous != current,
                    child: const Keypad(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
