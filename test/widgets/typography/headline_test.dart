import 'package:aonic/theme/theme.dart';
import 'package:aonic/widgets/typography/headline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_widget_wrapper.dart';

void main() {
  group('Widgets - Headline()', () {
    const headline = "Equipment";

    void headlineTest(int level) {
      final headlingLevel = level + 1;
      final expextedFontSize = headlingLevel > 1 ? fontSizeL : fontSizeXl;

      testWidgets('Renders headline level $headlingLevel correctly', (tester) async {
        await tester.pumpWidget(TestWidgetWrapper(Headline(
          headline,
          level: headlingLevel,
        )));

        expect(find.text(headline), findsOneWidget);

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontSize, equals(expextedFontSize));
      });
    }

    Iterable<int>.generate(6).toList().forEach(headlineTest);
  });
}
