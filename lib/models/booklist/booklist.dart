import '../../types/types.dart';
import 'booklist_item.dart';

class Booklist {
  final List<dynamic> _bookData;
  final List<int> _supportedBooks;
  final String _language;
  late final List<BooklistItem> _books;

  Booklist(this._bookData, this._supportedBooks, this._language) {
    int bookNumber = 1;
    _books = [];

    for (var book in _bookData) {
      _books.add(BooklistItem(book.title, book.code, bookNumber, _language, _supportedBooks));
      bookNumber += 1;
    }
  }

  List<BooklistItem> getBooks() {
    return _books;
  }

  Json toJson() => {'books': _books.map((book) => book.toJson()).toList()};

  @override
  String toString() {
    return toJson().toString();
  }
}
