import 'package:flutter/material.dart';

class NewSalePriceContentHeader extends StatelessWidget {
  final String price;
  const NewSalePriceContentHeader({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "Sale Price\n",
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: price,
            style: textTheme.displayLarge?.copyWith(
              fontFamily: 'anonymous pro',
              fontWeight: FontWeight.bold,
              letterSpacing: 1.6,
            ),
          ),
          TextSpan(
            text: 'Ks',
            style: textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
