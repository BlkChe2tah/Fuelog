import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petrol_ledger/features/sale_price_history/bloc/sale_price_history_bloc.dart';
import 'package:petrol_ledger/features/sale_price_history/view/sale_price_history_layout.dart';
import 'package:petrol_ledger/injection_container.dart';

class SalePriceHistoryScreen extends StatelessWidget {
  const SalePriceHistoryScreen({super.key});

  static get route => MaterialPageRoute(builder: (_) => const SalePriceHistoryScreen());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => $sl<SalePriceHistoryBloc>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          scrolledUnderElevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: const SafeArea(
          child: SalePriceHistoryLayout(),
        ),
      ),
    );
  }
}
