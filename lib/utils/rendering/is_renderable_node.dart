import 'package:xml/xml.dart';

bool isRenderableNode(XmlElement xml) {
  if (xml.childElements.isEmpty) {
    return false;
  }

  final nodeName = xml.childElements.elementAt(0).name.toString();

  switch (nodeName) {
    case "blockquote":
    case "choice":
    case "combat":
    case "deadend":
    case "dl":
    case "illustration":
    case "ol":
    case "p":
    case "section":
    case "signpost":
    case "ul":
      return true;

    default:
      return false;
  }
}
