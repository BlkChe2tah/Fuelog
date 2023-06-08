import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:petrol_ledger/model/sale_item_data.dart';
import 'package:petrol_ledger/provider/sale_history_provider.dart';
import 'package:petrol_ledger/res/colors.dart';
import 'package:petrol_ledger/screens/sale_history/sale_item.dart';
import 'package:petrol_ledger/utils/extension.dart';
import 'package:petrol_ledger/utils/ui_state.dart';
import 'package:provider/provider.dart';

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

  SaleItem _loadHeaderRow(Color color, TextStyle? style) {
    return SaleItem(
      color: color,
      height: 42.0,
      date: SaleItem.loadTextView(
        label: 'Date',
        style: style,
      ),
      amount: SaleItem.loadTextView(
        label: 'Amount',
        style: style,
      ),
      liter: SaleItem.loadTextView(
        label: 'Liter',
        style: style,
      ),
      salePrice: SaleItem.loadTextView(
        label: 'Sale Price',
        style: style,
      ),
      name: SaleItem.loadTextView(
        label: 'Debtor Name',
        style: style,
      ),
    );
  }

  SaleItem _loadDataRow(
      SaleItemData data, ColorScheme colorScheme, TextStyle? style) {
    var date = data.date;
    var backgroundColor =
        data.name.isEmpty ? colorScheme.surface : kDebtorRowColor;
    if (data.name.isNotEmpty) {
      style = style?.copyWith(
        color: colorScheme.onInverseSurface,
      );
    }
    return SaleItem(
      height: 48.0,
      color: backgroundColor,
      date: SaleItem.loadTextView(
        label: '${date.day}/${date.month}/${date.year}',
        style: style,
      ),
      amount: SaleItem.loadTextView(
        label: data.amount.toString(),
        style: style,
      ),
      liter: SaleItem.loadTextView(
        label: data.liter.toStringAsFixed(3),
        style: style,
      ),
      salePrice: SaleItem.loadTextView(
        label: data.salePrice.toString(),
        style: style,
      ),
      name: SaleItem.loadTextView(
        label: data.name,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var headerLabelStyle =
        context.loadTextTheme().labelLarge?.copyWith(fontSize: 16.0);
    var bodyTextStyle = context.loadTextTheme().bodyLarge?.copyWith(
          color: context.loadColorScheme().onSurfaceVariant,
          fontSize: 18.0,
        );
    var physis = const BouncingScrollPhysics();
    return Column(
      children: [
        SizedBox(
          height: 42,
          child: ListView(
            controller: _headerViewController,
            scrollDirection: Axis.horizontal,
            physics: physis.applyTo(
              const AlwaysScrollableScrollPhysics(),
            ),
            children: [
              _loadHeaderRow(
                  context.loadColorScheme().surfaceVariant, headerLabelStyle),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _bodyViewController,
            physics: physis.applyTo(
              const AlwaysScrollableScrollPhysics(),
            ),
            child: SizedBox(
              width: SaleItem.width,
              child: Selector<SaleHistoryProvider, List<SaleItemData>>(
                selector: (_, provider) {
                  var state = provider.uiState;
                  if (state is SuccessMode<List<SaleItemData>>) {
                    return state.result;
                  }
                  return List.empty();
                },
                builder: (context, result, child) {
                  return ListView.builder(
                    itemCount: result.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _loadDataRow(
                        result[index],
                        context.loadColorScheme(),
                        bodyTextStyle,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
