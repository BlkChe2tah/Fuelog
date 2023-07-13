abstract class UiState {}

class InitialMode extends UiState {}

class LoadingMode extends UiState {}

class EmptyMode extends UiState {}

class SuccessMode<T> extends UiState {
  final T result;
  SuccessMode({required this.result});
}

class ErrorMode extends UiState {
  final String message;
  ErrorMode({required this.message});
}

class ExportingMode extends UiState {}

class ExportingSuccessMode extends UiState {}

class ExportingErrorMode extends UiState {}
