import 'package:flutter/material.dart';

import '../../types/types.dart';
import '../mixins/content_renderer.dart';

class HeadlineText extends StatelessWidget with ContentRenderer {
  final BookText text;
  final int? level;

  const HeadlineText(
    this.text, {
    this.level = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? style;

    switch (level) {
      case 2:
        style = Theme.of(context).textTheme.headline2;
        break;

      case 3:
        style = Theme.of(context).textTheme.headline3;
        break;

      case 4:
        style = Theme.of(context).textTheme.headline4;
        break;

      case 5:
        style = Theme.of(context).textTheme.headline5;
        break;

      case 6:
        style = Theme.of(context).textTheme.headline6;
        break;

      default:
        style = Theme.of(context).textTheme.headline1;
        break;
    }

    return Text(
      text,
      style: style,
    );
  }
}
