import 'package:collection/collection.dart';
import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'subcontent/illustration_instance_model.dart';
import 'tag.dart';

const realIllustrator = 'Gary Chalk';

enum IllustrationType {
  float,
  inline,
  none,
  unknown,
}

class IllustrationTagModel extends TagModel {
  final List<IllustrationInstanceModel> instances = [];
  late final IllustrationType type;
  late final BookText creator;
  late final BookText description;

  // ignore: unused_element
  IllustrationTagModel._();

  IllustrationTagModel.fromXml(XmlElement xml) {
    try {
      final typeName = getAttribute('class', xml);

      if (typeName.isEmpty) {
        type = IllustrationType.none;
      } else {
        type = IllustrationType.values.byName(typeName);
      }
    } on ArgumentError {
      type = IllustrationType.unknown;
    }

    final metaXml = xml.getElement('meta');

    creator = metaXml != null ? getValue('creator', metaXml) : '';
    // TODO - Make a text element list
    description = metaXml != null ? getValue('description', metaXml) : '';
    xml.findElements('instance').forEach((instance) {
      instances.add(IllustrationInstanceModel.fromXml(instance));
    });
  }

  @override
  Json toJson() => {
        'creator': creator,
        'description': description,
        'instances': instances.map((instance) => instance.toJson()).toList(),
        'type': type.name,
      };

  IllustrationInstanceModel? getHtmlInstance() {
    return instances
        .firstWhereOrNull((instance) => instance.type == InstanceType.html);
  }
}
