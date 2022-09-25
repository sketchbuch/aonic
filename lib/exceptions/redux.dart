class ReducerException implements Exception {
  String message;

  ReducerException(this.message);

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}
