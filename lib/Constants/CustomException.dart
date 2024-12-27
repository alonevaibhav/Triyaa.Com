class CustomException implements Exception {
  final int statusCode;
  final String message;

  CustomException(this.statusCode, this.message);

  @override
  String toString() {
    return 'Status Code: $statusCode, Message: $message';
  }
}
