import 'package:xml/xml.dart';

import '../../../types/types.dart';
import 'subcontent/description_list_item_model.dart';
import 'tag.dart';

class DescriptionListTagModel extends TagModel {
  final List<DescriptionListItemModel> items = [];

  // ignore: unused_element
  DescriptionListTagModel._();

  DescriptionListTagModel.fromXml(XmlElement xml) {
    for (var child in xml.childElements) {
      items.add(DescriptionListItemModel.fromXml(child));
    }
  }

  @override
  Json toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
      };
}
