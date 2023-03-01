import 'package:flutter/material.dart';

import '../../../constants/layout.dart';
import '../../../models/book/content/subcontent/description_list_item_model.dart';
import '../../mixins/content_renderer.dart';

class DescriptionTermListItem extends StatelessWidget with ContentRenderer {
  final DescriptionListItemModel item;
  final bool isFirstTerm;

  const DescriptionTermListItem(this.item, this.isFirstTerm, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flattenedTexts = getFlattenedTexts(item.texts);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding:
                EdgeInsets.only(top: isFirstTerm ? sizeZero : paddingNormal),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: flattenedTexts.map((text) {
                  final style = getTextElementTextStyle(text)
                      .copyWith(fontWeight: FontWeight.bold);

                  return TextSpan(text: text.text, style: style);
                }).toList(),
              ),
            ),
          ), //text
        ),
      ],
    );
  }
}
