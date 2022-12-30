import 'package:lonewolf_new/config/book_config.dart';
import 'package:test/test.dart';

void main() {
  group('Config - BookConfig()', () {
    const code = "01fftd";
    const useIllustrators = "Gary Chalk:JC Alvarez / Jonathan Blake:Jonathan Blake";

    final BookConfigItem bookData = {
      "code": code,
      "useIllustrators": useIllustrators,
    };

    final expectedJson = {
      "code": code,
      "useIllustrators": useIllustrators,
    };

    final bookConfig = BookConfig(bookData);

    test('Returns expected JSON', () {
      expect(bookConfig.toJson(), equals(expectedJson));
    });

    test('Returns expected string', () {
      expect(bookConfig.toString(), equals(expectedJson.toString()));
    });
  });
}
