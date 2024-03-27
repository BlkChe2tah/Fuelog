import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/core/design_system/values.dart';
import 'package:petrol_ledger/features/home/model/sale_request_data.dart';
import 'package:petrol_ledger/core/ui/components/new_sale_confirm_content_header.dart';

class NewSaleConfirmContentLayout extends StatefulWidget {
  final String liter;
  final String amount;
  const NewSaleConfirmContentLayout({super.key, required this.liter, required this.amount});

  @override
  State<NewSaleConfirmContentLayout> createState() => _NewSaleConfirmContentLayoutState();
}

class _NewSaleConfirmContentLayoutState extends State<NewSaleConfirmContentLayout> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      constraints: const BoxConstraints.tightFor(width: 360),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: colorScheme.surface,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(kXLarge),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NewSaleConfirmContentHeader(
                  liter: widget.liter,
                  amount: widget.amount,
                ),
                const SizedBox(height: kHuge),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: kLarge,
                    vertical: kXLarge,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                      width: kDebtorCardBorderSize,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Symbols.person_rounded,
                        size: 48.0,
                        color: colorScheme.outlineVariant,
                        weight: 200,
                      ),
                      const SizedBox(width: kLarge),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Debtor Name',
                              style: textTheme.labelMedium?.copyWith(
                                color: colorScheme.outlineVariant,
                              ),
                            ),
                            const SizedBox(height: kMedium),
                            TextField(
                              controller: _controller,
                              maxLines: 1,
                              cursorWidth: 2.4,
                              cursorColor: colorScheme.onSurface,
                              enableSuggestions: false,
                              autocorrect: false,
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: 'Debtor Name',
                                hintStyle: TextStyle(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: kLarge,
                                  vertical: kSmall,
                                ),
                                fillColor: colorScheme.surfaceVariant,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(kLarge),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: kSmall),
                // Text(
                //   "Debtor name is optional",
                //   style: textTheme.labelSmall?.copyWith(
                //     color: colorScheme.onSurfaceVariant,
                //   ),
                // ),
                const SizedBox(height: kLarge),
                SizedBox(
                  height: kButtonSize,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          SaleRequestData(
                            liter: widget.liter,
                            amount: widget.amount,
                            name: _controller.text,
                          ));
                    },
                    child: Text(
                      'ADD',
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
