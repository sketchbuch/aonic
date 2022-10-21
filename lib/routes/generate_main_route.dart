import 'package:flutter/material.dart';
import 'package:lonewolf_new/pages/not_found/not_found_page.dart';

import '../pages/book/book_page.dart';
import '../pages/home/home_page.dart';
import 'routes.dart';

Route<dynamic> generateMainRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return MaterialPageRoute(builder: (_) => HomePage());

    case bookRoute:
    case bookPlayRoute:
      return MaterialPageRoute(builder: (_) => BookPage());

    default:
      return MaterialPageRoute(builder: (_) => NotFoundPage(settings));
  }
}
