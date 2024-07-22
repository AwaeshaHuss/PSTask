import 'dart:io';

class ServerException implements Exception {}

class OfflineException implements SocketException {
  @override
  final String message;
  final Uri? uri;

  OfflineException({required this.message, this.uri});

  @override
  String toString() {
    return 'OfflineException: $message${uri != null ? ', URI: $uri' : ''}';
  }

  @override
  InternetAddress? get address => null;

  @override
  OSError? get osError => null;

  @override
  int? get port => null;
}

class IncorrectPasswordException implements Exception{}

class UserNotFoundException implements Exception{}

class InvalidOTPException implements Exception{}