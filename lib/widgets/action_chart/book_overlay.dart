import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class BookOverlay extends StatelessWidget {
  final Widget child;

  const BookOverlay({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colourPrimary.withAlpha(100),
      width: double.infinity,
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
    );
  }
}
