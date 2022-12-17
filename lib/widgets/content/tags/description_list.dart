import 'package:flutter/material.dart';

import '../../../models/book/content/description_list_tag.dart';
import '../../../models/book/content/subcontent/description_list_item.dart';
import '../../mixins/content_renderer.dart';
import '../content_container.dart';

const newline = '\n';

class DescriptionList extends StatelessWidget with ContentRenderer {
  final DescriptionListTag tag;

  const DescriptionList(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tag.items.map<Widget>((item) {
        return ContentContainer(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: item.texts.map((text) {
                String textContent = item.displayAsLines ? '${text.text}$newline' : text.text;
                FontStyle style = getTextElementStyle(text);
                FontWeight weight = getTextElementWeight(text);

                if (item.type == DescriptionIemType.dt) {
                  weight = FontWeight.bold;
                }

                return TextSpan(text: textContent, style: TextStyle(fontWeight: weight, fontStyle: style));
              }).toList(),
            ),
          ),
        );
      }).toList(),
    );
  }
}
