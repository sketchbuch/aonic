import '../store/get_it/get_it.dart';
import '../types/types.dart';
import 'models/action_chart_model.dart';

ActionChartModel createActionChart() {
  getIt.registerSingleton<ActionChartModel>(ActionChartModel());
  return getIt<ActionChartModel>();
}

final actionChart = createActionChart();

void setupActionChart(String chartType, ActionChartModel ac, Json chartData) {
  ac.setup((chartData[chartType] ?? {}) as Json);
}
