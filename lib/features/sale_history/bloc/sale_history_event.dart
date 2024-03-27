part of 'sale_history_bloc.dart';

sealed class SaleHistoryEvent extends Equatable {
  const SaleHistoryEvent();

  @override
  List<Object> get props => [];
}

final class _Inialized extends SaleHistoryEvent {
  final DateTime date;
  const _Inialized(this.date);

  @override
  List<Object> get props => [
        date
      ];
}

final class LoadAllSalesRecordByDate extends SaleHistoryEvent {
  final DateTime date;
  const LoadAllSalesRecordByDate(this.date);

  @override
  List<Object> get props => [
        date
      ];
}

final class ExportSaleRecord extends SaleHistoryEvent {
  final ExportType type;
  const ExportSaleRecord(this.type);

  @override
  List<Object> get props => [
        type
      ];
}
