import 'package:flutter/material.dart';

import '../pages/book/display/book_display_page.dart';
import '../pages/book/selection/book_selection_page.dart';
import '../pages/not_found/not_found_page.dart';
import 'routes.dart';

Route<dynamic> generateBookRoute(RouteSettings settings) {
  Widget page;

  switch (settings.name) {
    case bookPlayRoute:
      page = const BookDisplayPage();
      break;

    case bookRoute:
      page = BookSelectionPage();
      break;

    default:
      page = NotFoundPage(settings, showAppBar: false);
      break;
  }

  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
}
