import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petrol_ledger/features/home/bloc/home_bloc.dart';
import 'package:petrol_ledger/core/design_system/values.dart';
import 'package:petrol_ledger/core/ui/components/keypad_display_item.dart';
import 'package:petrol_ledger/core/ui/components/keypad_type_selector.dart';
import 'package:provider/provider.dart';

class KeypadDisplay extends StatelessWidget {
  const KeypadDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kBodyPadding),
      child: Column(
        children: [
          KeypadTypeSelector(
              selectedType: context.select<HomeBloc, KeypadType>((bloc) => bloc.state.keypadType),
              onKeypadTypeChanged: (type) {
                context.read<HomeBloc>().add(KeypadTypeChanged(type: type));
              }),
          const Spacer(),
          KeypadDisplayItem(
            label: 'Price',
            value: context.select<HomeBloc, String>((bloc) => bloc.state.price),
          ),
          const Spacer(),
          KeypadDisplayItem(
            label: 'Liter',
            value: context.select<HomeBloc, String>((bloc) => bloc.state.liter),
            isHighlightColor: context.select<HomeBloc, KeypadType>((bloc) => bloc.state.keypadType) == KeypadType.liter,
          ),
          const Spacer(),
          KeypadDisplayItem(
            label: 'Amount',
            value: context.select<HomeBloc, String>((bloc) => bloc.state.amount),
            isHighlightColor: context.select<HomeBloc, KeypadType>((bloc) => bloc.state.keypadType) == KeypadType.amount,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
