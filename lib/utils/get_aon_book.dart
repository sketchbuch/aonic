import 'package:http/http.dart' as https;

Future<String> getAonBook([String bookCode = '01fftd']) async {
  Uri uri = Uri.parse('https://www.projectaon.org/data/trunk/en/xml/$bookCode.xml');
  var response = await https.get(uri);

  if (response.statusCode == 200) {
    return response.body;
  }

  throw Exception('Failed to load data');
}
