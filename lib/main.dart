import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:xml/xml.dart';

import 'i18n/translations.g.dart';
import 'models/book.dart';
import 'utils/get_aon_book_data.dart';
import 'utils/xml/helpers.dart';
import 'widgets/book_display.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'Lone Wolf'),
      locale: TranslationProvider.of(context).flutterLocale,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: LocaleSettings.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: 'Lone Wolf App',
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

    if (gamebook != null) {
      Book book = Book.fromXml(gamebook);
      setState(() {
        _book = book;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = _book;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}${book != null ? ': ${book.title}' : ''}'),
      ),
      body: Center(
        child: book != null ? BookDisplay(book) : const Text('Book NOT loaded'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
