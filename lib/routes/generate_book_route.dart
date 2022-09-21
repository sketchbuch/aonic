import 'package:flutter/material.dart';

import '../pages/book/display/book_display_page.dart';
import '../pages/book/selection/book_selection_page.dart';
import '../pages/not_found/not_found_page.dart';
import 'routes.dart';

Route<dynamic> generateBookRoute(RouteSettings settings) {
  late Widget page;

  switch (settings.name) {
    case bookBackmatterRoute:
    case bookFrontmatterRoute:
    case bookNumberedRoute:
      page = const BookDisplayPage();
      break;

    case bookRoute:
      page = BookSelectionPage();
      break;

    default:
      return MaterialPageRoute(builder: (_) => NotFoundPage(settings, showAppBar: false));
  }

  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
}
