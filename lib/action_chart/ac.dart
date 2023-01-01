import '../store/get_it/get_it.dart';
import '../types/types.dart';
import 'models/action_chart.dart';

ActionChart createActionChart() {
  getIt.registerSingleton<ActionChart>(ActionChart());
  return getIt<ActionChart>();
}

final actionChart = createActionChart();

void setupActionChart(String chartType, ActionChart ac, Json chartData) {
  ac.setup((chartData[chartType] ?? {}) as Json);
}
