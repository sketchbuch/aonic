import '../../types/types.dart';
import 'booklist_item_model.dart';

class BooklistModel {
  final List<dynamic> _bookData;
  final List<int> _supportedBooks;
  final String _language;
  final List<BooklistItemModel> _books = [];

  BooklistModel(this._bookData, this._supportedBooks, this._language);

  void createBookList() {
    int bookNumber = 1;

    for (var book in _bookData) {
      _books.add(BooklistItemModel(
          book.title, book.code, bookNumber, _language, _supportedBooks));
      bookNumber += 1;
    }
  }

  List<BooklistItemModel> getBooks() {
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
