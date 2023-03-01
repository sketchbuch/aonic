import 'package:xml/xml.dart';

import '../../../constants/books.dart';
import '../../../constants/characters.dart';
import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import '../content/subcontent/text_element_model.dart';

class FootnoteModel {
  final TextElements texts = [];
  int footnoteNumber = 1;
  late final BookText sectionTitle;
  late final String id;
  late final String idRef;
  late final String sectionId;

  // ignore: unused_element
  FootnoteModel._();

  FootnoteModel.fromXml(XmlElement xml, BookText secTitle, String secId) {
    id = getAttribute('id', xml);
    idRef = getAttribute('idref', xml);
    sectionId = secId;
    sectionTitle = secTitle;

    final textXml = xml.getElement('p');
    if (textXml != null) {
      texts.addAll(getTextElementList(textXml));
    }
  }

  Json toJson() => {
        'footnoteNumber': footnoteNumber,
        'id': id,
        'idRef': idRef,
        'sectionId': sectionId,
        'sectionTitle': sectionTitle,
        'texts': texts.map((text) => text.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }

  bool _isNumberedFootnote() {
    return _getSectionIdRef().startsWith(sectionPrefix);
  }

  String _getSectionNumberStr() {
    return _getSectionIdRef().replaceFirst(sectionPrefix, '');
  }

  String _getSectionIdRef() {
    return idRef.split('-').first;
  }

  TextElements getSectionPrefix(TranslatedText prefixText) {
    final TextElements sectionPrefix = [];

    sectionPrefix.add(TextElementModel.fromTxt(
      _isNumberedFootnote()
          ? prefixText.replaceFirst('#', _getSectionNumberStr())
          : sectionTitle,
      type: DisplayType.link,
      attributes: {'idref': _getSectionIdRef()},
    ));
    sectionPrefix.add(TextElementModel.fromTxt(': $newLine'));

    return sectionPrefix;
  }
}
