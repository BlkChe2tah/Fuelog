import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petrol_ledger/common/ui_state.dart';
import 'package:petrol_ledger/features/sale_price_history/bloc/sale_price_history_bloc.dart';
import 'package:petrol_ledger/features/sale_price_history/model/sale_price_item_view_data.dart';
import 'package:petrol_ledger/features/sale_price_history/view/current_sale_price_header.dart';
import 'package:petrol_ledger/core/ui/components/sale_price_history_item_view.dart';

class SalePriceHistoryLayout extends StatelessWidget {
  const SalePriceHistoryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CurrentSalePriceHeader(),
        Expanded(
          child: BlocBuilder<SalePriceHistoryBloc, SalePriceHistoryState>(
            builder: (context, state) {
              if (state.uiState is LoadingState || state.uiState is InitialState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.uiState is ErrorState) {
                return Center(
                  child: Text((state.uiState as ErrorState).message),
                );
              }
              final successData = state.uiState as SuccessState<List<SalePriceItemViewData>>;
              if (successData.data.isEmpty) {
                return const Center(
                  child: Text("Empty sale price"),
                );
              }
              return ListView.builder(
                itemCount: successData.data.length,
                itemBuilder: (context, index) {
                  return SalePriceHistoryItemView(data: successData.data[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
