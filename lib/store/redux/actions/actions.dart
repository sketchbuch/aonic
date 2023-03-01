import 'package:flutter/material.dart';

import '../../../models/book/book_model.dart';
import '../../../models/booklist/booklist_item_model.dart';

class GoToPageAction {
  final int page;

  GoToPageAction(this.page);
}

class LoadBookFaliure {
  final String errorMessage;

  LoadBookFaliure(this.errorMessage);
}

class LoadBookRequest {
  final String bookCode;
  final int bookNumber;

  LoadBookRequest(this.bookCode, this.bookNumber);
}

class LoadBookSuccess {
  final Book book;
  final String xml;

  LoadBookSuccess(this.xml, this.book);
}

class NavigateAction {
  final GlobalKey<NavigatorState> navigator;
  final String route;

  NavigateAction(this.navigator, this.route);
}

class NextPageAction {}

class PageNavigateAction {
  final GlobalKey<NavigatorState> navigator;
  final String route;

  PageNavigateAction(this.navigator, this.route);
}

class PrevPageAction {}

class SelectBookAction {
  final BooklistItemModel? book;

  SelectBookAction(this.book);
}

class UnloadBookAction {}
