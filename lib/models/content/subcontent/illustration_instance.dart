import 'package:recase/recase.dart';
import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';

// TODO - Add instance type text: <instance class="text
enum MimeType {
  gif('image/gif'),
  none('none'),
  png('image/png'),
  unknown('unknown');

  const MimeType(this.value);
  final String value;
}

enum InstanceType {
  html('html'),
  htmlCompatible('html-compatible'),
  pdf('pdf'),
  text('text'),
  none('none'),
  unknown('unknown');

  const InstanceType(this.value);
  final String value;
}

class IllustrationInstance {
  late final InstanceType type;
  late final int height;
  late final int width;
  late final MimeType mimeType;
  late final String fileName;

  // ignore: unused_element
  IllustrationInstance._();

  IllustrationInstance.fromXml(XmlElement xml) {
    fileName = getAttribute('src', xml);
    width = int.parse(getAttribute('width', xml, '0'));
    height = int.parse(getAttribute('height', xml, '0'));

    try {
      final typeName = getAttribute('class', xml);

      if (typeName.isEmpty) {
        type = InstanceType.none;
      } else {
        type = InstanceType.values.byName(ReCase(typeName).camelCase);
      }
    } on ArgumentError {
      type = InstanceType.unknown;
    }

    final mimeTypeName = getAttribute('mime-type', xml);

    if (mimeTypeName.isEmpty) {
      mimeType = MimeType.none;
    } else {
      if (mimeTypeName == 'image/png') {
        mimeType = MimeType.png;
      } else if (mimeTypeName == 'image/gif') {
        mimeType = MimeType.gif;
      } else {
        mimeType = MimeType.unknown;
      }
    }
  }

  Json toJson() => {
        'fileName': fileName,
        'height': height,
        'mimeType': mimeType.value,
        'type': type.value,
        'width': width,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
