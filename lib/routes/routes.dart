import 'package:flutter/cupertino.dart';

const homeRoute = '/';

const bookRoute = '/book';
const bookBackmatterRoute = '$bookRoute/backmatter';
const bookFrontmatterRoute = '$bookRoute/frontmatter';
const bookNumberedRoute = '$bookRoute/numbered';

const settingsRoute = '/settings';

final GlobalKey<NavigatorState> mainNav = GlobalKey();
final GlobalKey<NavigatorState> bookNav = GlobalKey();
