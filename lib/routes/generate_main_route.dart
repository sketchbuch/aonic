import 'package:flutter/material.dart';
import 'package:lonewolf_new/pages/not_found/not_found_page.dart';

import '../pages/book/book_page.dart';
import '../pages/home/home_page.dart';
import 'routes.dart';

Route<dynamic> generateMainRoute(RouteSettings settings) {
  Widget page;

  switch (settings.name) {
    case homeRoute:
      page = HomePage();
      break;

    case bookRoute:
    case bookPlayRoute:
      page = BookPage();
      break;

    default:
      page = NotFoundPage(settings);
      break;
  }

  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
}
