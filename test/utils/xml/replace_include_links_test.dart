import 'package:lonewolf_new/utils/i18n/map_urls.dart';
import 'package:lonewolf_new/utils/xml/replace_include_links.dart';
import 'package:test/test.dart';

void main() {
  group('Util - replaceIncludeLinks()', () {
    final mappedUrls = mapUrls();

    replaceIncludeLinksTest(String includeStr, Map<String, String> includeLinks) {
      test('Replaces "&link.$includeStr;" with correct URL', () {
        expect(
          replaceIncludeLinks(
              'Link 1 <a href="&link.$includeStr;">Text</a>, Link 2 <a href="&link.$includeStr;">Text</a>.',
              includeLinks),
          equals(
              'Link 1 <a href="${includeLinks[includeStr]}">Text</a>, Link 2 <a href="${includeLinks[includeStr]}">Text</a>.'),
        );
      });
    }

    for (var key in mappedUrls.keys) {
      replaceIncludeLinksTest(key, mappedUrls);
    }
  });
}
