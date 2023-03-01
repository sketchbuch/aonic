import 'package:aonic/models/book/section/meta_link_model.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const metaLinkIdRef = 'title';
const metaLinkType = 'prev';
const metaLinkXml = '<link class="$metaLinkType" idref="$metaLinkIdRef" />';
const metaLinkJson = {
  "idRef": metaLinkIdRef,
  "type": metaLinkType,
};

void main() {
  group('Model - MetaLinkModel()', () {
    final tag = MetaLinkModel.fromXml(getRootXmlElement(metaLinkXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(metaLinkJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(metaLinkJson.toString()));
    });
  });
}
