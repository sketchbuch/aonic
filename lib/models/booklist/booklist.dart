import '../../types/types.dart';
import 'booklist_item.dart';

class Booklist {
  final List<dynamic> _bookData;
  final List<int> _supportedBooks;
  final String _language;
  final List<BooklistItem> _books = [];

  Booklist(this._bookData, this._supportedBooks, this._language);

  void createBookList() {
    int bookNumber = 1;

    for (var book in _bookData) {
      _books.add(BooklistItem(book.title, book.code, bookNumber, _language, _supportedBooks));
      bookNumber += 1;
    }
  }

  List<BooklistItem> getBooks() {
    if (_books.isEmpty && _bookData.isNotEmpty) {
      createBookList();
    }

    return _books;
  }

  Json toJson() => {'books': getBooks().map((book) => book.toJson()).toList()};

  @override
  String toString() {
    return toJson().toString();
  }
}
