import 'package:intl/intl.dart';
import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
import 'content/subcontent/text_element.dart';
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

  // ignore: unused_element
  Meta._();

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

    creators = xml.findElements('creator').map((elementXml) => Creator.fromXml(elementXml)).toList();
    descriptions = xml.findElements('description').map((elementXml) => Description.fromXml(elementXml)).toList();
    rights = xml.findElements('rights').map((elementXml) => Right.fromXml(elementXml)).toList();
  }

  String getCreator() {
    final metaCreator = creators.where((creator) => creator.type == CreatorType.short);

    if (metaCreator.isNotEmpty) {
      return metaCreator.elementAt(0).text;
    }

    return '';
  }

  List<List<TextElement>> getDescriptionTexts([DescriptionType? type]) {
    List<List<TextElement>> texts = [];

    /* if (descriptions.isNotEmpty) {
      final visibleDescriptions = type != null ? descriptions.where((descrip) => descrip.type == type) : descriptions;

      for (var description in visibleDescriptions) {
        texts.addAll(description.texts);
      }
    } */

    return texts;
  }

  List<List<TextElement>> getRightTexts([RightType? type]) {
    List<List<TextElement>> texts = [];

    /* if (rights.isNotEmpty) {
      final visibleRights = type != null ? rights.where((right) => right.type == type) : rights;

      for (var right in visibleRights) {
        texts.addAll(right.texts);
      }
    } */

    return texts;
  }

  Json toJson() => {
        'creators': creators.map((creator) => creator.toJson()).toList(),
        'descriptions': descriptions.map((description) => description.toJson()).toList(),
        'publicationDate': publicationDate != null ? DateFormat('dd-MM-yyyy').format(publicationDate!) : '',
        'publisher': publisher,
        'rights': rights.map((right) => right.toJson()).toList(),
        'title': title,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
