import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {
  final Widget child;
  final double bottomPadding;

  const ContentContainer({required this.child, this.bottomPadding = 16.0, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: child,
    );
  }
}
