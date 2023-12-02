import 'dart:io';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'api_error_model.dart';

part 'api_error_handle.freezed.dart';

// use error handle by freezed package

@freezed
class ErrorHandle with _$ErrorHandle {
  const factory ErrorHandle.requestCancelled() = RequestCancelled;

  const factory ErrorHandle.unauthorizedRequest(String reason) =
      UnauthorizedRequest;

  const factory ErrorHandle.badRequest(String error) = BadRequest;

  const factory ErrorHandle.badCertificate() = BadCertificate;

  const factory ErrorHandle.notFound(String reason) = NotFound;

  const factory ErrorHandle.methodNotAllowed() = MethodNotAllowed;

  const factory ErrorHandle.notAcceptable() = NotAcceptable;

  const factory ErrorHandle.requestTimeout() = RequestTimeout;

  const factory ErrorHandle.sendTimeout() = SendTimeout;

  const factory ErrorHandle.unprocessableEntity(String reason) =
      UnprocessableEntity;

  const factory ErrorHandle.conflict() = Conflict;

  const factory ErrorHandle.internalServerError() = InternalServerError;

  const factory ErrorHandle.notImplemented() = NotImplemented;

  const factory ErrorHandle.serviceUnavailable() = ServiceUnavailable;

  const factory ErrorHandle.noInternetConnection() = NoInternetConnection;

  const factory ErrorHandle.formatException() = FormatException;

  const factory ErrorHandle.unableToProcess() = UnableToProcess;

  const factory ErrorHandle.defaultError(String error) = DefaultError;

  const factory ErrorHandle.unexpectedError() = UnexpectedError;

  static ErrorHandle _handleResponse(Response? response) {
    ErrorModel errorModel = ErrorModel.fromMap(response?.data);

    int statusCode = response?.statusCode ?? 0;

    final messageModel = errorModel.message;

    final message =
        messageModel is List ? messageModel.join('\n') : messageModel;

    switch (statusCode) {
      case 400:
        return ErrorHandle.badRequest(
          message,
        );
      case 401:
        return ErrorHandle.unauthorizedRequest(
          message,
        );
      case 403:
        return ErrorHandle.unauthorizedRequest(
          message,
        );
      case 404:
        return ErrorHandle.notFound(
          message,
        );
      case 409:
        return const ErrorHandle.conflict();
      case 408:
        return const ErrorHandle.requestTimeout();
      case 422:
        return ErrorHandle.unprocessableEntity(
          " $message",
        );
      case 500:
        return const ErrorHandle.internalServerError();
      case 503:
        return const ErrorHandle.serviceUnavailable();
      default:
        var responseCode = statusCode;
        return ErrorHandle.defaultError(
          "Received invalid status code: $responseCode",
        );
    }
  }

  static ErrorHandle getDioException(error) {
    print("Error =========>>>>> $error");

    if (error is Exception) {
      try {
        late ErrorHandle errorHandle;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorHandle = const ErrorHandle.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              errorHandle = const ErrorHandle.requestTimeout();
              break;
            case DioExceptionType.connectionError:
              errorHandle = const ErrorHandle.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
              errorHandle = const ErrorHandle.sendTimeout();
              break;
            case DioExceptionType.badResponse:
              errorHandle = ErrorHandle._handleResponse(error.response);
              break;
            case DioExceptionType.sendTimeout:
              errorHandle = const ErrorHandle.sendTimeout();
              break;
            case DioExceptionType.badCertificate:
              errorHandle = const ErrorHandle.badCertificate();
              break;
            case DioExceptionType.unknown:
              errorHandle = const ErrorHandle.noInternetConnection();
              break;
          }
        } else if (error is SocketException) {
          errorHandle = const ErrorHandle.noInternetConnection();
        } else {
          errorHandle = const ErrorHandle.unexpectedError();
        }
        return errorHandle;
      } on FormatException catch (_) {
        return const ErrorHandle.formatException();
      } catch (_) {
        return const ErrorHandle.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const ErrorHandle.unableToProcess();
      } else {
        return const ErrorHandle.unexpectedError();
      }
    }
  }

  static String getErrorMessage(ErrorHandle errorHandle) {
    var errorMessage = "";
    errorHandle.when(
      notImplemented: () {
        errorMessage = "Not Implemented";
      },
      requestCancelled: () {
        errorMessage = "Request Cancelled";
      },
      internalServerError: () {
        errorMessage = "Internal Server Error";
      },
      notFound: (String reason) {
        errorMessage = reason;
      },
      serviceUnavailable: () {
        errorMessage = "Service unavailable";
      },
      methodNotAllowed: () {
        errorMessage = "Method Allowed";
      },
      badRequest: (String error) {
        errorMessage = error;
      },
      unauthorizedRequest: (String error) {
        errorMessage = error;
      },
      unprocessableEntity: (String error) {
        errorMessage = error;
      },
      unexpectedError: () {
        errorMessage = "Unexpected error occurred";
      },
      requestTimeout: () {
        errorMessage = "Connection request timeout";
      },
      noInternetConnection: () {
        errorMessage = "No internet connection";
      },
      conflict: () {
        errorMessage = "Error due to a conflict";
      },
      sendTimeout: () {
        errorMessage = "Send timeout in connection with API server";
      },
      unableToProcess: () {
        errorMessage = "Unable to process the data";
      },
      defaultError: (String error) {
        errorMessage = error;
      },
      formatException: () {
        errorMessage = "Unexpected error occurred";
      },
      notAcceptable: () {
        errorMessage = "Not acceptable";
      },
      badCertificate: () {
        errorMessage = "Bad Certificate";
      },
    );
    return errorMessage;
  }
}
