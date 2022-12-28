import 'package:flutter/material.dart';

import '../../constants/layout.dart';
import '../../theme/theme.dart';
import 'content_container.dart';

class DividingLine extends StatelessWidget {
  final double bottomPadding;

  const DividingLine({Key? key, this.bottomPadding = paddingLarge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      bottomPadding: bottomPadding,
      child: const Divider(
        color: colourOverlay,
        height: 1.0,
      ),
    );
  }
}
