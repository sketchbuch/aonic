import 'package:intl/intl.dart';
import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
import 'content/paragraph_tag.dart';
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

  List<ParagraphTag> getDescriptionParagraphs([DescriptionType? type]) {
    final List<ParagraphTag> paragraphTags = [];

    if (descriptions.isNotEmpty) {
      final filteredDescriptions = type != null ? descriptions.where((model) => model.type == type) : descriptions;

      if (filteredDescriptions.isNotEmpty) {
        for (var description in filteredDescriptions) {
          for (var paragraph in description.paragraphs) {
            paragraphTags.add(paragraph);
          }
        }
      }
    }

    return paragraphTags;
  }

  List<ParagraphTag> getRightParagraphs([RightType? type]) {
    final List<ParagraphTag> paragraphTags = [];

    if (rights.isNotEmpty) {
      final filteredRights = type != null ? rights.where((model) => model.type == type) : rights;

      if (filteredRights.isNotEmpty) {
        for (var description in filteredRights) {
          for (var paragraph in description.paragraphs) {
            paragraphTags.add(paragraph);
          }
        }
      }
    }

    return paragraphTags;
  }

  getFormattedPublicationDate([String dateFormat = 'dd/MM/yyyy']) {
    return DateFormat(dateFormat).format(publicationDate!);
  }
}
