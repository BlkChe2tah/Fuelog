import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petrol_ledger/features/sale_history/bloc/sale_history_bloc.dart';
import 'package:petrol_ledger/features/sale_history/view/sale_history_appbar.dart';
import 'package:petrol_ledger/features/sale_history/view/sale_history_list.dart';
import 'package:petrol_ledger/injection_container.dart';

class SaleHistoryScreen extends StatelessWidget {
  const SaleHistoryScreen({super.key});

  static get route => MaterialPageRoute(builder: (_) => const SaleHistoryScreen());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => $sl<SaleHistoryBloc>(),
      child: const Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SaleHistoryAppbar(),
              Expanded(
                child: SaleHistoryList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
