import 'package:aonic/theme/theme.dart';
import 'package:flutter/material.dart';

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
