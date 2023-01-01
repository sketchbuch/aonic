import '../../types/types.dart';

typedef BookConfigDataItem = Map<String, Object>;
typedef BookConfigData = List<BookConfigDataItem>;

class BookConfig {
  late String code;
  late String useIllustrators;

  BookConfig(BookConfigDataItem book) {
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
