import 'package:flutter/material.dart';

import '../../../constants/layout.dart';
import '../../../theme/theme.dart';

class ImageBox extends StatelessWidget {
  final Widget child;

  const ImageBox(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colourWhite,
        border: Border.all(color: colourOverlay, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
      ),
      padding: const EdgeInsets.all(paddingLarge),
      child: child,
    );
  }
}
