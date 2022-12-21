import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'content_container.dart';

class DividingLine extends StatelessWidget {
  const DividingLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ContentContainer(
      child: Divider(
        color: colourOverlay,
        height: 1.0,
      ),
    );
  }
}
