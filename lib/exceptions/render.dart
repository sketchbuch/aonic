class RenderException implements Exception {
  String message;

  RenderException(this.message);

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}
