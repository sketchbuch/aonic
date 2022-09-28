import 'package:flutter/services.dart' show rootBundle;

Future<String> getAonBookFileData() async {
  try {
    return await rootBundle.loadString('samples/sample.xml');
  } catch (error) {
    throw Exception('Error (local): ${error.toString()}');
  }
}
