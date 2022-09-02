import 'package:lonewolf_new/models/book/section/footnote.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - Footnote()', () {
    const id = 'sect113-1-foot';
    const idRef = 'sect113-1';

    const xml = '''<footnote id="$id" idref="$idRef">
      <p>The wording of this section assumes that you have come from <a idref="sect28">Section 28</a>. If you have just reached this section for the first time from <a idref="sect42">Section 42</a>, read the last sentence and two choices as follows: <quote><ch.lellips/>As you eat you notice that the path starts to curve towards the north. If you wish to follow it, <a idref="sect28">turn to 28</a>. If you wish to return the way you have come, <a idref="sect42">turn to 42</a>.</quote></p>
    </footnote>''';
    final tag = Footnote.fromXml(getRootXmlElement(xml));

    final expected = {
      "id": id,
      "idRef": idRef,
      "texts": [
        {"attrs": {}, "displayType": "plain", "text": "The wording of this section assumes that you have come from "},
        {
          "attrs": {"idref": "sect28"},
          "displayType": "link",
          "text": "Section 28"
        },
        {
          "attrs": {},
          "displayType": "plain",
          "text": ". If you have just reached this section for the first time from "
        },
        {
          "attrs": {"idref": "sect42"},
          "displayType": "link",
          "text": "Section 42"
        },
        {"attrs": {}, "displayType": "plain", "text": ", read the last sentence and two choices as follows: "},
        {
          "attrs": {},
          "displayType": "quote",
          "text":
              "…As you eat you notice that the path starts to curve towards the north. If you wish to follow it, turn to 28. If you wish to return the way you have come, turn to 42."
        }
      ]
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
