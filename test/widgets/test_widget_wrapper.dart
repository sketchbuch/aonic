import 'package:flutter/material.dart';
import 'package:lonewolf_new/theme/theme.dart';

class TestWidgetWrapper extends StatelessWidget {
  final Widget child;

  const TestWidgetWrapper(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
      theme: getTheme(),
    );
  }
}
