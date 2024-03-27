import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petrol_ledger/common/extension.dart';
import 'package:petrol_ledger/core/data/model/sale_price_state.dart';
import 'package:petrol_ledger/common/ui_state.dart';
import 'package:petrol_ledger/core/design_system/values.dart';
import 'package:petrol_ledger/core/ui/components/keypad_type_selector.dart';
import 'package:petrol_ledger/features/home/model/sale_request_data.dart';
import 'package:petrol_ledger/core/ui/new_sale_confirm_content_layout.dart';
import 'package:petrol_ledger/features/home/bloc/home_bloc.dart';
import 'package:petrol_ledger/core/ui/keypad.dart';
import 'package:petrol_ledger/features/home/widgets/keypad_display.dart';
import 'package:petrol_ledger/core/ui/new_sale_price_content_layout.dart';
import 'package:petrol_ledger/features/sale_history/sale_history_screen.dart';
import 'package:petrol_ledger/features/sale_price_history/sale_price_history_screen.dart';

class KeypadLayout extends StatefulWidget {
  const KeypadLayout({super.key});

  @override
  State<KeypadLayout> createState() => _KeypadLayoutState();
}

class _KeypadLayoutState extends State<KeypadLayout> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<HomeBloc, HomeState>(
      listener: (_, state) async {
        if (state.priceState == SalePriceStatus.error) {
          final result = await _showNewSalePriceDialog();
          if (result != null && context.mounted) {
            context.read<HomeBloc>().add(AddNewSalePrice(price: result));
          }
        }
        final uiState = state.uiState;
        if (uiState is ErrorState && context.mounted) {
          context.showSnackBar(uiState.message);
          context.read<HomeBloc>().add(const ResetUiState());
        }
        if (uiState is SuccessState && context.mounted && uiState.data is String) {
          context.showSnackBar(uiState.data.toString());
          context.read<HomeBloc>().add(const ResetUiState());
        }
      },
      child: Stack(
        children: [
          Column(
            children: [
              const Expanded(child: KeypadDisplay()),
              Keypad(
                keypadType: context.select<HomeBloc, KeypadType>((bloc) => bloc.state.keypadType),
                onValueKeyPressed: (key, isZeroKey) {
                  context.read<HomeBloc>().add(ValueKeyPressed(value: key, isZeroKey: isZeroKey));
                },
                onDeleteKeyPressed: () async {
                  context.read<HomeBloc>().add(const DeleteKeyPressed());
                },
                onSaleHistoryKeyPressed: () {
                  Navigator.push(context, SaleHistoryScreen.route);
                },
                onSalePriceHistoryKeyPressed: () {
                  Navigator.push(context, SalePriceHistoryScreen.route);
                },
                onSubmitKeyPressed: () async {
                  final amount = context.read<HomeBloc>().state.amount;
                  final liter = context.read<HomeBloc>().state.liter;
                  if (amount == "0") {
                    context.showSnackBar("Sale amount can't be zero");
                    return;
                  }
                  final result = await _showNewSaleConfirmDialog(liter: liter, amount: amount);
                  if (result != null && context.mounted) {
                    context.read<HomeBloc>().add(AddNewSale(data: result));
                  }
                },
              ),
            ],
          ),
          Visibility(
            visible: context.select<HomeBloc, UiState>((bloc) => bloc.state.uiState) is LoadingState,
            child: Container(
              color: colorScheme.background.withOpacity(0.8),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<int?> _showNewSalePriceDialog() {
    return showDialog<int?>(
      context: context,
      barrierDismissible: false,
      barrierColor: Theme.of(context).colorScheme.background.withOpacity(0.95),
      builder: (_) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (!didPop) {
              SystemNavigator.pop();
            }
          },
          child: const AlertDialog(
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.symmetric(horizontal: kLarge, vertical: kHuge),
            content: NewSalePriceContentLayout(showHintView: true),
          ),
        );
      },
    );
  }

  Future<SaleRequestData?> _showNewSaleConfirmDialog({required String liter, required String amount}) {
    return showDialog<SaleRequestData?>(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.symmetric(horizontal: kLarge, vertical: kHuge),
          content: NewSaleConfirmContentLayout(
            liter: liter,
            amount: amount,
          ),
        );
      },
    );
  }
}
