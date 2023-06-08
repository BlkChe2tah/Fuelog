import 'package:flutter/material.dart';
import 'package:petrol_ledger/component/close_btn.dart';
import 'package:petrol_ledger/res/values.dart';
import 'package:petrol_ledger/screens/amount_confirm/amount_confirm_submit_btn.dart';
import 'package:petrol_ledger/screens/amount_confirm/animated_debtor.dart';
import 'package:petrol_ledger/screens/amount_confirm/sale_amount_view.dart';
import 'package:petrol_ledger/utils/extension.dart';

class AmountConfirmContainer extends StatefulWidget {
  const AmountConfirmContainer({super.key});

  @override
  State<AmountConfirmContainer> createState() => _AmountConfirmContainerState();
}

class _AmountConfirmContainerState extends State<AmountConfirmContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void _setupAnimation() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
  }

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: context.loadColorScheme().surface,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(kXLarge),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SaleAmountView(),
                const SizedBox(height: kHuge),
                RepaintBoundary(
                  child: AnimatedDebtor(
                    animationListener: () {
                      _controller.forward();
                    },
                    controller: _controller,
                    colorScheme: context.loadColorScheme(),
                  ),
                ),
                const SizedBox(height: kLarge),
                const AmountConfirmSubmitBtn(),
              ],
            ),
          ),
          const Positioned(
            top: 0.0,
            right: 0.0,
            child: CloseBtn(),
          ),
        ],
      ),
    );
  }
}
