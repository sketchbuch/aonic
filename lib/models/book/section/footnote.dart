import 'package:xml/xml.dart';

import '../../../constants/books.dart';
import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import '../content/subcontent/text_element.dart';

class Footnote {
  final List<TextElement> texts = [];
  late final String id;
  late final String idRef;

  // ignore: unused_element
  Footnote._();

  Footnote.fromXml(XmlElement xml) {
    id = getAttribute('id', xml);
    idRef = getAttribute('idref', xml);

    final textXml = xml.getElement('p');
    if (textXml != null) {
      texts.addAll(getTextElementList(textXml));
    }
  }

  Json toJson() => {
        'id': id,
        'idRef': idRef,
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

  List<TextElement> getSectionPrefix(TranslatedText prefixText) {
    final List<TextElement> sectionPrefix = [];

    sectionPrefix.add(TextElement.fromTxt('('));
    sectionPrefix.add(TextElement.fromTxt(
      _isNumberedFootnote() ? prefixText.replaceFirst('#', _getSectionNumberStr()) : _getSectionIdRef(),
      type: DisplayType.link,
      attributes: {'idref': _getSectionIdRef()},
    ));
    sectionPrefix.add(TextElement.fromTxt(') '));

    return sectionPrefix;
  }

  List<TextElement> getFootnoteNumber(int footnoteIndexNumber) {
    final List<TextElement> footnoteNumber = [];

    footnoteNumber.add(TextElement.fromTxt('['));
    footnoteNumber.add(TextElement.fromTxt(
      footnoteIndexNumber.toString(),
      type: DisplayType.link,
      attributes: {'idref': '$_getSectionIdRef()#$idRef'},
    ));
    footnoteNumber.add(TextElement.fromTxt('] '));

    return footnoteNumber;
  }
}
