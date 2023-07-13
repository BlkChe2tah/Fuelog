import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/core/values.dart';
import 'package:petrol_ledger/core/utils/extension.dart';

class PermissionMessageDialogLayout extends StatelessWidget {
  final String message;
  final String btnLabel1;
  final String btnLabel2;
  final VoidCallback callback1;
  final VoidCallback callback2;
  const PermissionMessageDialogLayout({
    super.key,
    required this.message,
    required this.btnLabel1,
    required this.btnLabel2,
    required this.callback1,
    required this.callback2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: context.loadColorScheme().surface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: kLarge),
          Icon(
            Symbols.folder_managed,
            color: context.loadColorScheme().primary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHuge,
              vertical: kLarge,
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: context.loadTextTheme().labelLarge?.copyWith(
                    fontSize: 18.0,
                  ),
            ),
          ),
          Divider(
            color: context.loadColorScheme().onSurfaceVariant,
            thickness: 0.4,
          ),
          TextButton(
            onPressed: callback1,
            child: Text(
              btnLabel1,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          Divider(
            color: context.loadColorScheme().onSurfaceVariant,
            thickness: 0.4,
          ),
          TextButton(
            onPressed: callback2,
            child: Text(
              btnLabel2,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
