import 'package:flutter/material.dart';

import '../../theme/theme.dart';

const appBarHeight = 56.0;

class BookOverlay extends StatelessWidget {
  final Widget child;

  const BookOverlay({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      top: 0.0 + appBarHeight,
      child: Container(
        color: colourPrimary.withAlpha(100),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: colourBorder,
                width: 1,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: colourPaper,
            ),
            child: Column(children: [child]),
          ),
        ),
      ),
    );
  }
}
