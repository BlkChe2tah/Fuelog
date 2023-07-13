import 'package:flutter/material.dart';
import 'package:petrol_ledger/core/values.dart';
import 'package:petrol_ledger/features/amount_collect/amount_confirm/debtor_card.dart';
import 'package:petrol_ledger/core/utils/extension.dart';

class AnimatedDebtor extends StatelessWidget {
  late final Animation<double> controller;
  late final Animation<double> buttonOpacity;
  late final Animation<double> cardOpacity;
  late final Animation<Color?> borderColor;
  late final Animation<double> cardHeight;
  late final Animation<double> borderRadius;

  final ColorScheme colorScheme;
  final VoidCallback animationListener;

  AnimatedDebtor({
    super.key,
    required this.controller,
    required this.animationListener,
    required this.colorScheme,
  }) {
    // Border Radius
    borderRadius = Tween<double>(
      begin: kButtonSize,
      end: kBorderRadius,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.000,
          0.300,
          curve: Curves.easeOut,
        ),
      ),
    );
    // Border Color
    borderColor =
        ColorTween(begin: colorScheme.primary, end: Colors.transparent).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.300,
          1.000,
          curve: Curves.easeOut,
        ),
      ),
    );
    // Debtor card height
    cardHeight =
        Tween<double>(begin: kButtonSize, end: kDebtorCardSize).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.300,
          0.600,
          curve: Curves.easeOut,
        ),
      ),
    );
    // Opacity for button
    buttonOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.500,
          0.800,
          curve: Curves.easeOut,
        ),
      ),
    );
    // Opacity for card
    cardOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.600,
          1.000,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          children: [
            Opacity(
              opacity: cardOpacity.value,
              child: SizedBox(
                height: cardHeight.value,
                child: child,
              ),
            ),
            Visibility(
              visible: !controller.isCompleted,
              child: Opacity(
                opacity: buttonOpacity.value,
                child: SizedBox(
                  width: double.infinity,
                  height: cardHeight.value,
                  child: OutlinedButton(
                    onPressed: animationListener,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(borderRadius.value)),
                      side: BorderSide(
                        width: kDebtorCardBorderSize,
                        color: colorScheme.primary,
                      ),
                    ),
                    child: Text(
                      'ADD DEBTOR NAME',
                      style: context.loadTextTheme().labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            letterSpacing: 1.8,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      child: const DebtorCard(),
    );
  }
}
