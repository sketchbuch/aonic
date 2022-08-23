import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

import 'models/book.dart';
import 'utils/get_aon_book_data.dart';
import 'utils/xml/helpers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lone Wolf App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Lone Wolf'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Book? _book;

  void _incrementCounter() async {
    final bookData = await getAonBookData();
    final bookXml = XmlDocument.parse(cleanXmlString(bookData));
    final gamebook = bookXml.getElement('gamebook');
    print('### Step 1');

    if (gamebook != null) {
      print('### Step 2');
      Book book = Book.fromXml(gamebook);
      setState(() {
        _book = book;
      });
      print('### BOOK');
      /* debugPrint('### backmatter: ${book.backmatter.length}');
      debugPrint('### frontmatter: ${book.frontmatter.length}');
      debugPrint('### backmatter: ${book.numbered.length}'); */
      print(book.frontmatter.elementAt(0).toJson());
      print('### /BOOK');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
