import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/core/design_system/values.dart';

class ExportTypeSelector extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback? onSelectorClicked;
  const ExportTypeSelector({
    super.key,
    required this.title,
    required this.subtitle,
    this.isSelected = false,
    this.onSelectorClicked,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    var color = isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant;
    return GestureDetector(
      onTap: onSelectorClicked,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kLarge,
          vertical: kMedium,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius),
          border: Border.all(color: color),
        ),
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title,
                      style: textTheme.labelLarge?.copyWith(
                        fontSize: 18,
                        color: color,
                      ),
                    ),
                    TextSpan(
                      text: "\n$subtitle",
                      style: textTheme.labelMedium?.copyWith(
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: kMedium),
            Visibility(
              visible: isSelected,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: Icon(
                Symbols.check_circle_rounded,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
