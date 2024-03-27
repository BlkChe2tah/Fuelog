import 'package:equatable/equatable.dart';

sealed class Result<T> extends Equatable {
  @override
  List<Object?> get props => [];
}

final class Success<T> extends Result<T> {
  final T data;
  Success(this.data);

  @override
  List<Object?> get props => [
        data
      ];
}

final class Error<Void> extends Result<Void> {
  final Exception exception;
  Error(this.exception);

  @override
  List<Object?> get props => [
        exception
      ];
}
