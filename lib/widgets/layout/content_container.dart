import 'package:flutter/material.dart';

import '../../constants/layout.dart';

class ContentContainer extends StatelessWidget {
  final Widget child;
  final double bottomPadding;
  final double width;

  const ContentContainer(
      {required this.child, this.bottomPadding = paddingLarge, this.width = maxContentWidth, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(bottom: bottomPadding),
        width: width > sizeZero ? width : null,
        child: child,
      ),
    );
  }
}
