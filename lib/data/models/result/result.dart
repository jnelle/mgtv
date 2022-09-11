import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mgtv/data/app_error.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success({required T data}) = Success<T>;

  const factory Result.failure({required AppError error}) = Failure<T>;

  static Result<T> guard<T>(T Function() body) {
    try {
      return Result<T>.success(data: body());
    } on Exception catch (e) {
      return Result<T>.failure(error: AppError(e));
    }
  }

  static Future<Result<T>> guardFuture<T>(Future<T> Function() future) async {
    try {
      return Result<T>.success(data: await future());
    } on Exception catch (e) {
      return Result<T>.failure(error: AppError(e));
    }
  }

  bool get isSuccess =>
      when(success: (T data) => true, failure: (AppError e) => false);

  bool get isFailure => !isSuccess;

  void ifSuccess(Function(T data) body) {
    maybeWhen(
      success: (T data) => body(data),
      orElse: () {
        // no-op
      },
    );
  }

  void ifFailure(Function(AppError e) body) {
    maybeWhen(
      failure: (AppError e) => body(e),
      orElse: () {
        // no-op
      },
    );
  }

  T get dataOrThrow {
    return when(
      success: (T data) => data,
      failure: (AppError e) => throw e,
    );
  }
}

extension ResultObjectExt<T> on T {
  Result<T> get asSuccess => Result<T>.success(data: this);

  Result<T> asFailure(Exception e) => Result<T>.failure(error: AppError(e));
}
