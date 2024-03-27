import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:petrol_ledger/common/ui_state.dart';
import 'package:petrol_ledger/features/sale_history/bloc/sale_history_bloc.dart';
import 'package:petrol_ledger/features/sale_history/model/sale_item_view_data.dart';
import 'package:petrol_ledger/core/ui/components/sale_item.dart';

class SaleHistoryList extends StatefulWidget {
  const SaleHistoryList({super.key});

  @override
  State<SaleHistoryList> createState() => _SaleHistoryListState();
}

class _SaleHistoryListState extends State<SaleHistoryList> {
  late final LinkedScrollControllerGroup _controllers;
  late final ScrollController _headerViewController;
  late final ScrollController _bodyViewController;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _headerViewController = _controllers.addAndGet();
    _bodyViewController = _controllers.addAndGet();
  }

  @override
  void dispose() {
    _headerViewController.dispose();
    _bodyViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaleHistoryBloc, SaleHistoryState>(
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
        final successData = state.uiState as SuccessState<List<SaleItemViewData>>;
        if (successData.data.isEmpty) {
          return const Center(
            child: Text("Empty sale record"),
          );
        }
        return Column(
          children: [
            SizedBox(
              height: 42,
              child: ListView(
                controller: _headerViewController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                children: const [
                  SaleItemHeader()
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _bodyViewController,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: SizedBox(
                  width: SaleItemView.width,
                  child: ListView.builder(
                    itemCount: successData.data.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final currentData = successData.data[index];
                      return SaleItemBody(
                        date: currentData.date,
                        amount: currentData.amount,
                        liter: currentData.liter,
                        salePrice: currentData.salePrice,
                        name: currentData.name,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
