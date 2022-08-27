import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
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
  late final IllustrationType type;
  late final List<IllustrationInstance> instances;
  late final String creator;
  late final String description;
  late final bool isRealIllustration;

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
    description = metaXml != null ? getValue('description', metaXml) : '';
    isRealIllustration = creator == realIllustrator ? true : false;
    instances = xml.findElements('instance').map((instance) => IllustrationInstance.fromXml(instance)).toList();
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
