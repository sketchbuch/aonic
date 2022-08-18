import 'package:xml/xml.dart';

import '../utils/xml/helpers.dart';

class Meta {
  late DateTime? publicationDate;
  late String publisher = '';
  late String title = '';

  Meta(this.title, this.publisher, this.publicationDate);

  Meta.fromXml(XmlElement xml) {
    publisher = getValue('publisher', xml);
    title = getValue('title', xml);

    final dateXml = xml.getElement('date');

    if (dateXml != null) {
      final day = getValue('day', dateXml);
      final month = getValue('month', dateXml);
      final year = getValue('year', dateXml);

      if (day.isNotEmpty && month.isNotEmpty && year.isNotEmpty) {
        publicationDate = DateTime.parse('$year-${month.padLeft(2, '0')}-${day.padLeft(2, '0')}');
      }
    }
  }
}
