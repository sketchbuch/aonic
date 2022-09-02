import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

import '../constants/supported_books.dart';
import '../exceptions/xml.dart';
import '../i18n/_generated_/translations.g.dart';
import '../models/book/book.dart';
import '../models/booklist/booklist.dart';
import '../models/booklist/booklist_item.dart';
import '../utils/get_aon_book_data.dart';
import '../utils/xml/helpers.dart';
import '../widgets/book_display.dart';
import '../widgets/book_selection.dart';

class HomePage extends StatefulWidget {
  final String title;
  final booklist = Booklist(t.booksLonewolf.books, lonewolfSupportedBooks, 'en').getBooks();

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Book? _book;
  BooklistItem? _selectedBook;

  void _handleBookLoad() async {
    final selectedBook = _selectedBook;

    if (selectedBook != null) {
      try {
        final bookData = await getAonBookData(selectedBook);
        final bookXml = XmlDocument.parse(cleanXmlString(bookData));
        final gamebook = bookXml.getElement('gamebook');

        if (gamebook != null) {
          Book book = Book.fromXml(gamebook);
          setState(() {
            _book = book;
          });
        } else {
          throw BookXmlException('Book data does not contain a "gamebook" element');
        }
      } catch (error) {
        print(error.toString());
      }
    }
  }

  void _handleBookSelection(BooklistItem? book) async {
    setState(() {
      _selectedBook = book;
    });
  }

  void _handleBookUnload() async {
    if (_book != null) {
      setState(() {
        _book = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final trans = t.home;
    final book = _book;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}${book != null ? ': ${book.title}' : ''}'),
      ),
      body: Center(
        child: book != null ? BookDisplay(book) : BookSelection(widget.booklist, _selectedBook, _handleBookSelection),
      ),
      floatingActionButton: _selectedBook == null
          ? null
          : FloatingActionButton(
              onPressed: book != null ? _handleBookUnload : _handleBookLoad,
              tooltip: book != null ? trans.loadButton.unload : trans.loadButton.load,
              child: Icon(book != null ? Icons.chevron_left : Icons.download),
            ),
    );
  }
}
