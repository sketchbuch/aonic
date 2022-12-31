import 'package:lonewolf_new/utils/rendering/is_renderable_node.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Util - isRenderableNode()', () {
    test('Returns false if no child nodes', () {
      const xml = '<p>This is a nodeless piece of XML.</p>';
      final xmlElement = getRootXmlElement(xml);

      expect(isRenderableNode(xmlElement), equals(false));
    });

    test('Returns false if not a renderable child node', () {
      const xml = '<p><a href="sect132">Section 123</a></p>';
      final xmlElement = getRootXmlElement(xml);

      expect(isRenderableNode(xmlElement), equals(false));
    });

    final renderableNodes = [
      "blockquote",
      "choice",
      "combat",
      "deadend",
      "dl",
      "illustration",
      "ol",
      "p",
      "section",
      "signpost",
      "ul",
    ];

    void renderTest(String nodeName) {
      test('Returns true if a $nodeName node', () {
        final xml = '<p><$nodeName>Section 123</$nodeName></p>';
        final xmlElement = getRootXmlElement(xml);

        expect(isRenderableNode(xmlElement), equals(true));
      });
    }

    renderableNodes.forEach(renderTest);
  });
}
