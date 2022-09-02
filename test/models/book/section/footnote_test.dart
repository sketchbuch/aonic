import 'package:lonewolf_new/models/book/section/footnote.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - Footnote()', () {
    const id = 'sect113-1-foot';
    const idRef = 'sect113-1';

    const xml = '''<footnotes>
       <footnote id="$id" idref="$idRef">
        <p>Each Meal of Laumspur may be consumed when prompted for a Meal, in which case it fulfils the Meal requirement in addition to restoring 3 <typ class="attribute">ENDURANCE</typ> points. Laumspur may also be consumed at any other time to restore <typ class="attribute">ENDURANCE</typ> without having any significance as a Meal.</p>
       </footnote>
      </footnotes>''';
    final tag = Footnote.fromXml(getRootXmlElement(xml));

    final expected = {
      "id": id,
      "idRef": idRef,
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
