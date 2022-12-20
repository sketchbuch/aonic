class GameplayException implements Exception {
  String message;

  GameplayException(this.message);

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}
