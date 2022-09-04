import 'package:flutter/material.dart';

import '../../i18n/_generated_/translations.g.dart';
import '../../routes/routes.dart';

class HomePage extends StatelessWidget {
  final trans = t.home;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trans.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Pick an option'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, bookRoute);
              },
              child: const Text('Book'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, settingsRoute);
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
