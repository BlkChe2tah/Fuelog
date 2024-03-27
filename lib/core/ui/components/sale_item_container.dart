import 'package:flutter/material.dart';
import 'package:petrol_ledger/core/design_system/values.dart';

class SaleItemContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  const SaleItemContainer({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(
        horizontal: kXLarge,
        vertical: kMedium,
      ),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.background,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
