import 'package:flutter/material.dart';

import '../../i18n/_generated_/translations.g.dart';
import '../../widgets/status_display.dart';

class NotFoundPage extends StatelessWidget {
  final RouteSettings settings;
  final trans = t.notfound;

  NotFoundPage(this.settings, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trans.title),
      ),
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
