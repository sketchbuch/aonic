import 'package:recase/recase.dart';
import 'package:xml/xml.dart';

import '../types/types.dart';
import '../utils/xml/helpers.dart';
import 'section/data.dart';
import 'section/meta.dart';

enum SectionType {
  backmatter('backmatter'),
  frontmatter('frontmatter'),
  frontmatterSeparate('frontmatter-separate'),
  numbered('numbered'),
  unknown('unknown');

  const SectionType(this.value);
  final String value;
}

class Section {
  late Data data;
  late Meta meta;
  late SectionType type;
  late String id;

  Section(this.id, this.type);

  Section.fromXml(XmlElement xml) {
    id = getAttribute('id', xml);

    try {
      final typeName = getAttribute('class', xml);
      type = SectionType.values.byName(ReCase(typeName).camelCase);
    } on ArgumentError {
      type = SectionType.unknown;
    }

    final metaXml = xml.getElement('meta');
    final dataXml = xml.getElement('data');

    if (metaXml != null) {
      meta = Meta.fromXml(metaXml);
    }

    if (dataXml != null) {
      data = Data.fromXml(dataXml);
    }
  }

  Json toJson() => {
        'data': data.toJson(),
        'id': id,
        'meta': meta.toJson(),
        'type': type.name,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
