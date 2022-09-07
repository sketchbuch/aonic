import 'package:lonewolf_new/models/booklist/booklist_item.dart';
import 'package:test/test.dart';

void main() {
  group('Model - BooklistItem():', () {
    const code = '01fftd';
    const isSupported = true;
    const language = 'en';
    const number = 1;
    const supportedBooks = [1];
    const title = 'Flight from the Dark';
    const xmlPath = 'https://www.projectaon.org/data/trunk/$language/xml/$code.xml';

    final expectedJson = {
      'code': code,
      'isSupported': isSupported,
      'number': number,
      'title': title,
      'xmlPath': xmlPath,
    };

    test('Returns expected JSON', () {
      final item = BooklistItem(title, code, number, language, supportedBooks);
      expect(item.toJson(), equals(expectedJson));
    });

    test('Returns expected string', () {
      final item = BooklistItem(title, code, number, language, supportedBooks);
      expect(item.toString(), equals(expectedJson.toString()));
    });

    test('isSupported is true if book number is in supportedBooks', () {
      final item = BooklistItem(title, code, 3, language, [3]);
      final json = item.toJson();
      expect(json['isSupported'], equals(true));
    });

    test('isSupported is false if book number is not in supportedBooks', () {
      final item = BooklistItem(title, code, 4, language, [3]);
      final json = item.toJson();
      expect(json['isSupported'], equals(false));
    });
  });
}
