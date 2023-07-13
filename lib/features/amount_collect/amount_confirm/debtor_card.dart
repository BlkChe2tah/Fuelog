import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/features/amount_collect/amount_confirm_screen_provider.dart';
import 'package:petrol_ledger/core/values.dart';
import 'package:petrol_ledger/core/utils/extension.dart';
import 'package:provider/provider.dart';

class DebtorCard extends StatefulWidget {
  const DebtorCard({
    super.key,
  });

  @override
  State<DebtorCard> createState() => _DebtorCardState();
}

class _DebtorCardState extends State<DebtorCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> animation;
  late ColorScheme colorScheme;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    colorScheme = Theme.of(context).colorScheme;
    animation = ColorTween(
      begin: colorScheme.onSurfaceVariant,
      end: colorScheme.onSurface,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    var disableColor = colorScheme.onSurfaceVariant;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: kDebtorCardSize,
          padding: const EdgeInsets.symmetric(
            horizontal: kLarge,
            vertical: kXLarge,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius),
            border: Border.all(
              color: animation.value ?? disableColor,
              width: kDebtorCardBorderSize,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Symbols.person_rounded,
                size: 56.0,
                color: animation.value ?? disableColor,
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
                      style: context.loadTextTheme().labelLarge?.copyWith(
                            color: animation.value ?? disableColor,
                            fontSize: 16.0,
                          ),
                    ),
                    const SizedBox(height: kMedium),
                    child!,
                  ],
                ),
              ),
            ],
          ),
        );
      },
      child: TextField(
        onChanged: (value) {
          if (value.length == 1) {
            controller.forward();
          }
          if (value.isEmpty) {
            controller.reverse();
          }
          context.read<AmountConfirmScreenProvider>().setDebtorName(value);
        },
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
        style: context.loadTextTheme().bodyLarge?.copyWith(
              fontSize: 18.0,
            ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
