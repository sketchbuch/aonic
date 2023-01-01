import '../store/get_it/get_it.dart';
import 'models/action_chart.dart';

ActionChart createActionChart() {
  getIt.registerSingleton<ActionChart>(ActionChart());
  return getIt<ActionChart>();
}

final actionChart = createActionChart();

void setupActionChart() {}
