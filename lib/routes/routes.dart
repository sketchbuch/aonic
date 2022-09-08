import 'package:flutter/cupertino.dart';

const homeRoute = '/';

const bookRoute = '/book';
const bookBackmatterRoute = '/book/backmatter';
const bookFrontmatterRoute = '/book/frontmatter';
const bookLoadingRoute = '/book/loading';
const bookNumberedRoute = '/book/numbered';

const settingsRoute = '/settings';

final GlobalKey<NavigatorState> mainNav = GlobalKey();
final GlobalKey<NavigatorState> bookNav = GlobalKey();
