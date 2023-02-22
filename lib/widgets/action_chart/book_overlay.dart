import 'package:flutter/material.dart';

const appBarHeight = 56.0;

class BookOverlay extends StatelessWidget {
  final Widget child;

  const BookOverlay(this.child, {Key? key}) : super(key: key);

  // TODO - Move numbers to constants
  @override
  Widget build(BuildContext context) {
    final appHeight = MediaQuery.of(context).size.height;
    final appWidth = MediaQuery.of(context).size.width;

    return Positioned(
      height: appHeight,
      left: 0.0,
      top: 0.0 + appBarHeight,
      width: appWidth,
      child: Container(
        color: const Color.fromARGB(66, 0, 0, 0),
        height: appHeight,
        width: appWidth,
        child: Positioned(
          height: appHeight - (50.0 + appBarHeight),
          left: 25.0,
          top: 25.0 + appBarHeight,
          width: appWidth - 50.0,
          child: Container(
            color: const Color.fromARGB(100, 100, 100, 200),
            child: Column(children: [child]),
          ),
        ),
      ),
    );
  }
}
