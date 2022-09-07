import 'dart:io';

Future<String> getAonBookFileData() async {
  try {
    final file = File('samples/sample.xml');
    return await file.readAsString();
  } catch (error) {
    throw Exception('Error (local): ${error.toString()}');
  }
}
