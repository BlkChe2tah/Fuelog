import 'package:equatable/equatable.dart';

sealed class UiState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class InitialState extends UiState {}

final class LoadingState extends UiState {}

final class ErrorState extends UiState {
  final String message;
  ErrorState(this.message);
}

final class SuccessState<T> extends UiState {
  final T data;
  SuccessState(this.data);
}
