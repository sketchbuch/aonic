import 'package:xml/xml.dart';

import '../types/types.dart';
import '../utils/xml/helpers.dart';
import 'meta/creator.dart';
import 'meta/description.dart';
import 'meta/right.dart';

class Meta {
  late DateTime? publicationDate;
  late List<Creator> creators = [];
  late List<Description> descriptions = [];
  late List<Right> rights = [];
  late String publisher = '';
  late String title = '';

  Meta(this.title, this.publisher, this.publicationDate, this.creators, this.descriptions, this.rights);

  Meta.fromXml(XmlElement xml) {
    publisher = getValue('publisher', xml);
    title = getValue('title', xml);

    final dateXml = xml.getElement('date');

    if (dateXml != null) {
      final day = getValue('day', dateXml);
      final month = getValue('month', dateXml);
      final year = getValue('year', dateXml);

      if (day.isNotEmpty && month.isNotEmpty && year.isNotEmpty) {
        publicationDate = getDate(year, month, day);
      }
    }

    final creatorXml = xml.findElements('creator');

    if (creatorXml.isNotEmpty) {
      creators = creatorXml.map((elementXml) => Creator.fromXml(elementXml)).toList();
    }

    final descriptionXml = xml.findElements('description');

    if (descriptionXml.isNotEmpty) {
      descriptions = descriptionXml.map((elementXml) => Description.fromXml(elementXml)).toList();
    }

    final rightsXml = xml.findElements('rights');

    if (rightsXml.isNotEmpty) {
      rights = rightsXml.map((elementXml) => Right.fromXml(elementXml)).toList();
    }
  }

  Json toJson() => {
        'creators': creators.map((creator) => creator.toJson()),
        'descriptions': descriptions.map((description) => description.toJson()),
        'publicationDate': publicationDate,
        'publisher': publisher,
        'rights': rights.map((right) => right.toJson()),
        'title': title,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
