part of 'sale_history_bloc.dart';

class SaleHistoryState extends Equatable {
  final String date;
  final DateTime currentSelectedDate;
  final int allRecordCount;
  final int recordCountByDate;
  final UiState uiState;

  SaleHistoryState copyWith({
    String? date,
    DateTime? currentSelectedDate,
    int? allRecordCount,
    int? recordCountByDate,
    UiState? uiState,
  }) {
    return SaleHistoryState(
      date: date ?? this.date,
      currentSelectedDate: currentSelectedDate ?? this.currentSelectedDate,
      allRecordCount: allRecordCount ?? this.allRecordCount,
      recordCountByDate: recordCountByDate ?? this.recordCountByDate,
      uiState: uiState ?? this.uiState,
    );
  }

  const SaleHistoryState({
    required this.date,
    required this.currentSelectedDate,
    required this.uiState,
    required this.allRecordCount,
    required this.recordCountByDate,
  });

  @override
  List<Object> get props => [
        date,
        uiState,
        allRecordCount,
        recordCountByDate,
      ];
}
