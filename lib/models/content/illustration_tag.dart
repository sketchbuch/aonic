import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
import 'subcontent/illustration_instance.dart';
import 'tag.dart';

const realIllustrator = 'Gary Chalk';

enum IllustrationType {
  inline,
  float,
  unknown;
}

class IllustrationTag extends Tag {
  late final IllustrationType type;
  late final List<IllustrationInstance> instances;
  late final String creator;
  late final String description;
  late final bool isRealIllustration;

  IllustrationTag(this.creator, this.description, this.type, this.instances);

  IllustrationTag.fromXml(XmlElement xml) {
    try {
      final typeName = getAttribute('class', xml);
      type = IllustrationType.values.byName(typeName);
    } on ArgumentError {
      type = IllustrationType.unknown;
    }

    final metaXml = xml.getElement('meta');

    creator = metaXml != null ? getValue('creator', metaXml) : '';
    description = metaXml != null ? getValue('description', metaXml) : '';
    isRealIllustration = creator == realIllustrator ? true : false;

    instances = [];
    final instanceXml = xml.findElements('instance');

    if (instanceXml.isNotEmpty) {
      for (var instance in instanceXml) {
        instances.add(IllustrationInstance.fromXml(instance));
      }
    }
  }

  @override
  Json toJson() => {
        'creator': creator,
        'description': description,
        'instances': instances.map((instance) => instance.toJson()).toList(),
        'isRealIllustration': isRealIllustration,
        'type': type.name,
      };
}
