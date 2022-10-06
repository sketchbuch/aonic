import 'package:flutter/material.dart';

import '../../i18n/_generated_/translations.g.dart';
import '../../widgets/page/status_display.dart';

class NotFoundPage extends StatelessWidget {
  final RouteSettings settings;
  final trans = t.notfound;
  final bool showAppBar;

  NotFoundPage(this.settings, {this.showAppBar = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text(trans.title),
            )
          : null,
      body: Center(
        child: StatusDisplay(
          trans.title,
          Icons.error,
          message: trans.message(route: settings.name.toString()),
        ),
      ),
    );
  }
}
