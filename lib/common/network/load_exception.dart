sealed class LoadException implements Exception {
  const LoadException();
}

final class NoConnectionException extends LoadException {
  const NoConnectionException();
}

final class TimeoutLoadException extends LoadException {
  const TimeoutLoadException();
}

final class NotFoundException extends LoadException {
  const NotFoundException();
}

final class ServerException extends LoadException {
  const ServerException(this.statusCode);

  final int? statusCode;
}

final class BadResponseException extends LoadException {
  const BadResponseException();
}
