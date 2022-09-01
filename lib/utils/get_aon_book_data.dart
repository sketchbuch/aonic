import 'dart:io';

import 'package:http/http.dart' as https;

import '../models/books/book_item.dart';

Future<String> getAonBookData(BookItem selectedBook) async {
  // https://www.projectaon.org/data/trunk/en/xml/01fftd.xml
  // view-source:https://www.projectaon.org/data/trunk/en/xml/01fftd.xml
  // https://www.projectaon.org/en/xhtml/lw/01fftd/title.htm
  Uri uri = Uri.parse(selectedBook.xmlPath);

  try {
    final response = await https.get(uri);

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Request Error: "${response.statusCode}"');
  } on HttpException {
    rethrow;
  } catch (error) {
    throw Exception('Error: $error');
  }
}
