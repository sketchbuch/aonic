import 'package:flutter/material.dart';

import '../../models/book/book.dart';
import '../../models/booklist/booklist_item.dart';

class GoToPageAction {
  final int page;

  GoToPageAction(this.page);
}

class LoadBookFaliure {
  final String errorMessage;

  LoadBookFaliure(this.errorMessage);
}

class LoadBookRequest {}

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

class PrevPageAction {}

class SelectBookAction {
  final BooklistItem? book;

  SelectBookAction(this.book);
}

class UnloadBookAction {}
