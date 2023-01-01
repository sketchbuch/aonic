import 'package:get_it/get_it.dart';

import 'data/book_config_data.dart';
import 'models/config.dart';

Config createConfig() {
  getIt.registerSingleton<Config>(Config());
  return getIt<Config>();
}

final getIt = GetIt.instance;
final config = createConfig();

void setupConfig() {
  config.setBookData(bookConfigData);
}
