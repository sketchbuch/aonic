import 'package:flutter/material.dart';

import '../../constants/layout.dart';

class ContentContainer extends StatelessWidget {
  final Widget child;
  final double bottomPadding;

  const ContentContainer({required this.child, this.bottomPadding = paddingLarge, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(bottom: bottomPadding),
        width: maxContentWidth,
        child: child,
      ),
    );
  }
}
