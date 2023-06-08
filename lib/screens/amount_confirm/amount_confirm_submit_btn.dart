import 'package:flutter/material.dart';
import 'package:petrol_ledger/provider/amount_confirm_screen_provider.dart';
import 'package:petrol_ledger/res/values.dart';
import 'package:petrol_ledger/utils/extension.dart';
import 'package:petrol_ledger/utils/ui_state.dart';
import 'package:provider/provider.dart';

class AmountConfirmSubmitBtn extends StatelessWidget {
  const AmountConfirmSubmitBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kButtonSize,
      child: Selector<AmountConfirmScreenProvider, UiState>(
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
            context.read<AmountConfirmScreenProvider>().save();
          },
          child: Text(
            'ADD',
            style: context.loadTextTheme().labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 1.8,
                ),
          ),
        ),
      ),
    );
  }
}
