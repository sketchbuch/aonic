import 'package:lonewolf_new/models/booklist/booklist.dart';
import 'package:test/test.dart';

class MockTranslationObject {
  String code;
  String title;

  MockTranslationObject(this.code, this.title);
}

void main() {
  group('Model - Booklist():', () {
    const bookOneCode = '01fftd';
    const bookOneTitle = 'Flight from the Dark';
    const bookTwoCode = '02fotw';
    const bookTwoTitle = 'Fire on the Water';

    const language = 'en';
    const supportedBooks = [1];
    final bookData = [
      MockTranslationObject(bookOneCode, bookOneTitle),
      MockTranslationObject(bookTwoCode, bookTwoTitle),
    ];

    final expected = {
      'books': [
        {
          'code': bookOneCode,
          'isSupported': true,
          'number': 1,
          'title': bookOneTitle,
          'xmlPath': 'https://www.projectaon.org/data/trunk/$language/xml/$bookOneCode.xml'
        },
        {
          'code': bookTwoCode,
          'isSupported': false,
          'number': 2,
          'title': bookTwoTitle,
          'xmlPath': 'https://www.projectaon.org/data/trunk/$language/xml/$bookTwoCode.xml'
        },
      ]
    };

    test('Returns expected JSON', () {
      final list = Booklist(bookData, supportedBooks, language);
      expect(list.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      final list = Booklist(bookData, supportedBooks, language);
      expect(list.toString(), equals(expected.toString()));
    });
  });
}
