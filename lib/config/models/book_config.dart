import '../../types/types.dart';

typedef BookConfigData = List<Json>;

class BookConfig {
  late String code;
  late String useIllustrators;

  BookConfig(Json book) {
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
