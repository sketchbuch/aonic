import 'package:flutter/material.dart';

import '../../models/booklist/booklist_item_model.dart';

class BookSelection extends StatelessWidget {
  final List<BooklistItemModel> _bookData;
  final void Function(BooklistItemModel?) _onChanged;
  final BooklistItemModel? _selectedBook;

  const BookSelection(this._bookData, this._selectedBook, this._onChanged,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<RadioListTile> supportedBooks = [];

    for (var book in _bookData) {
      if (book.isSupported()) {
        supportedBooks.add(RadioListTile<BooklistItemModel>(
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
