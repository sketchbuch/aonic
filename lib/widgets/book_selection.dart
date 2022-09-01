import 'package:flutter/material.dart';

import '../models/books/book_item.dart';

class BookSelection extends StatelessWidget {
  final List<BookItem> _bookData;
  final void Function(BookItem?) _onChanged;
  final BookItem? _selectedBook;

  const BookSelection(this._bookData, this._selectedBook, this._onChanged, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<RadioListTile> supportedBooks = [];

    for (var book in _bookData) {
      if (book.isSupported) {
        supportedBooks.add(RadioListTile<BookItem>(
          groupValue: _selectedBook,
          onChanged: _onChanged,
          title: Text(book.title),
          value: book,
        ));
      }
    }

    return Column(
      children: supportedBooks,
    );
  }
}
