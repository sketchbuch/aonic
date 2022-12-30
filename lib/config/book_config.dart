import '../types/types.dart';

typedef BookConfigItem = Map<String, Object>;
typedef BookConfigItems = List<BookConfigItem>;

class BookConfig {
  late String code;
  late String useIllustrators;

  BookConfig(BookConfigItem book) {
    code = book['code'] as String;
    useIllustrators = book['useIllustrators'] as String;
  }

  Json toJson() => {
        "code": code,
        "useIllustrators": useIllustrators,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
