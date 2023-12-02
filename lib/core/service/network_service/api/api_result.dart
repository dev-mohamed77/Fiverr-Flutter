import 'package:freezed_annotation/freezed_annotation.dart';

import 'api_error_handle.dart';

part 'api_result.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  factory ApiResult.success(T data) = Success<T>;
  factory ApiResult.failure(ErrorHandle errorHandle) = Failure<T>;
}
