

import 'package:flutter/cupertino.dart';

import '../../res/app_string.dart';

class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix $_message";
  }
}

class InternetException extends AppException {
  InternetException([String? message]) :
    super(message, AppString.noInternet);

}

class RequestTimeOut extends AppException {
  RequestTimeOut([String? message]) :
    super(message, AppString.requestTimeOut);

}

class ServerException extends AppException {
  ServerException([String? message]) :
    super(message, AppString.serverError);

}

class DatabaseException extends AppException {
  DatabaseException([String? message]):
    super(message, AppString.databaseError);

}

class InvalidUrl extends AppException {
  InvalidUrl([String? message]) :
    super(message, AppString.invalidUrl);

}

class UnauthorizedAccessException extends AppException {
  UnauthorizedAccessException([String? message]):
    super(message, AppString.invalidUser);

}

class FetchDataException extends AppException {
  FetchDataException([String? message]) :
    super(message, AppString.errorOccured);

}

class UnableToConvert extends AppException {
  UnableToConvert([String? message]) :
  super(message, AppString.errorDataType);

}

class UnableToLogin extends AppException {
  UnableToLogin([String? message]) :
    super(message, AppString.errorLogin);

}
class InternalServerException extends AppException {
  InternalServerException([String? message]) :
    super(message, AppString.errorLogin);

}
class AWSBucketException extends AppException {
  AWSBucketException([String? message]) : super(message, "AWS Bucket Error:");
}
class Uint8ListConvertException extends AppException {
  Uint8ListConvertException([String? message]) : super(message, "Uint8ListConvertException conversion error:");
}
class AppError extends AppException {
  AppError([String? message]) : super(message,"APP ERROR:");
}