import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class KeypadDisplayItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlightColor;

  const KeypadDisplayItem({
    super.key,
    required this.label,
    required this.value,
    this.isHighlightColor = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textColor = isHighlightColor ? colorScheme.onSurface : colorScheme.onSurfaceVariant;
    return SizedBox(
      height: 52.0,
      child: Row(
        children: [
          SizedBox(
            width: 102.0,
            child: Text(
              label,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: textTheme.titleLarge?.copyWith(
                color: textColor,
              ),
            ),
          ),
          Expanded(
            child: AutoSizeText(
              value,
              maxLines: 1,
              textAlign: TextAlign.end,
              minFontSize: 24.0,
              style: textTheme.displayMedium?.copyWith(
                fontFamily: 'anonymous pro',
                color: textColor,
                letterSpacing: 1.6,
                fontSize: 45.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
