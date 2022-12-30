import 'package:lonewolf_new/config/book_config.dart';
import 'package:lonewolf_new/config/config.dart';
import 'package:test/test.dart';

void main() {
  group('Config - Config()', () {
    const code1 = "01fftd";
    const code2 = "02fotw";
    const code3 = "03tcok";
    const useIllustrators = "Gary Chalk:JC Alvarez / Jonathan Blake:Jonathan Blake";

    final BookConfigItems bookdata = [
      {
        "code": code1,
        "useIllustrators": useIllustrators,
      },
      {
        "code": code2,
        "useIllustrators": useIllustrators,
      },
    ];

    final expectedJson = {
      "books": [
        {
          "code": code1,
          "useIllustrators": useIllustrators,
        },
        {
          "code": code2,
          "useIllustrators": useIllustrators,
        },
      ]
    };

    final config = Config(bookdata);

    test('Returns expected JSON', () {
      expect(config.toJson(), equals(expectedJson));
    });

    test('Returns expected string', () {
      expect(config.toString(), equals(expectedJson.toString()));
    });

    test('getBookByCode() returns expected item', () {
      final bookConfig = BookConfig(bookdata.elementAt(1));
      expect(config.getBookByCode(code2)?.toJson(), equals(bookConfig.toJson()));
    });

    test('getBookByCode() returns null if item not found', () {
      expect(config.getBookByCode(code3), equals(null));
    });
  });
}
