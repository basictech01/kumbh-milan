

class Error implements Exception {
  final dynamic message;

  Error([this.message]);

  String toString() {
    Object? message = this.message;
    if (message == null) return "Error";
    return "Error: $message";
  }
}

class UnAuthenticated extends Error {
  UnAuthenticated() : super("Unauthenticated");
}

class NetworkError extends Error {
  NetworkError([super.message]);
}

class ParsingError extends Error {
  ParsingError([super.message]);
}