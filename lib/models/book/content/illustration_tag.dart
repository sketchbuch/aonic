import 'package:collection/collection.dart';
import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'subcontent/illustration_instance.dart';
import 'tag.dart';

const realIllustrator = 'Gary Chalk';

enum IllustrationType {
  float,
  inline,
  none,
  unknown,
}

class IllustrationTag extends Tag {
  final List<IllustrationInstance> instances = [];
  late final IllustrationType type;
  late final BookText creator;
  late final BookText description;

  // ignore: unused_element
  IllustrationTag._();

  IllustrationTag.fromXml(XmlElement xml) {
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
      instances.add(IllustrationInstance.fromXml(instance));
    });
  }

  @override
  Json toJson() => {
        'creator': creator,
        'description': description,
        'instances': instances.map((instance) => instance.toJson()).toList(),
        'type': type.name,
      };

  IllustrationInstance? getHtmlInstance() {
    return instances.firstWhereOrNull((instance) => instance.type == InstanceType.html);
  }
}
