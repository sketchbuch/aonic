import 'package:get_it/get_it.dart';

import 'data/book_config_data.dart';
import 'models/config.dart';

final getIt = GetIt.instance;

void setupConfig() {
  getIt.registerSingleton<Config>(Config(bookConfigData));
}
