import 'dart:io';

import 'package:http/http.dart' as https;

Future<String> getAonBookData([String bookCode = '01fftd']) async {
  // https://www.projectaon.org/data/trunk/en/xml/01fftd.xml
  // view-source:https://www.projectaon.org/data/trunk/en/xml/01fftd.xml
  Uri uri = Uri.parse('https://www.projectaon.org/data/trunk/en/xml/$bookCode.xml');

  try {
    final response = await https.get(uri);

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Request Error: ${response.statusCode}');
  } on HttpException {
    rethrow;
  } catch (error) {
    throw Exception('Error: $error');
  }
}
