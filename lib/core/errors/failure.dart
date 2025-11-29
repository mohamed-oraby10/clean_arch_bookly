import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: 'connection timeout with Api server');
      case DioExceptionType.sendTimeout:
        return ServerFailure(message: 'send timeout with Api server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: 'receive timeout with Api server');
      case DioExceptionType.badCertificate:
        return ServerFailure(
          message: 'bad Certificate timeout with Api server',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response!.statusCode!,
          e.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(message: 'cancel timeout with Api server');
      case DioExceptionType.connectionError:
        return ServerFailure(message: 'connection Error with Api server');
      case DioExceptionType.unknown:
        return ServerFailure(
          message: 'there is unknown error, please try again',
        );
    }
  }

  factory ServerFailure.fromResponse(int statusCose, dynamic response) {
    if (statusCose == 404) {
      return ServerFailure(
        message: 'Your request was not found, please try later',
      );
    } else if (statusCose == 500) {
      return ServerFailure(
        message: 'There is a problem with server, please try later',
      );
    } else if (statusCose == 400 || statusCose == 401 || statusCose == 403) {
      return ServerFailure(message: response['error']['message']);
    } else {
      return ServerFailure(
        message: 'There is an error, please try again',
      );
    }
  }
}
