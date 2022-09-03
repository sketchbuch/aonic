import '../../models/book/book.dart';
import '../../models/booklist/booklist_item.dart';

class BookLoadedAction {
  final Book book;
  final bool isLoaded = true;
  final String xml;

  BookLoadedAction(this.xml, this.book);
}

class BookUnloadedAction {
  BookUnloadedAction();
}

class NextPageAction {
  NextPageAction();
}

class PrevPageAction {
  PrevPageAction();
}

class GoToPageAction {
  final int page;

  GoToPageAction(this.page);
}

class SelectBookAction {
  final BooklistItem? book;

  SelectBookAction(this.book);
}
