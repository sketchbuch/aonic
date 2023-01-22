import '../actions/action_chart.dart';
import '../actions/actions.dart';
import '../models/action_chart_state.dart';

ActionChartState actionChartStateReducer(ActionChartState actionChartState, action) {
  if (action is ActionChartOpen) {
    return actionChartState.copyWith(isVisible: true);
  } else if (action is ActionChartClose) {
    return actionChartState.copyWith(isVisible: false);
  } else if (action is LoadBookFaliure) {
    return actionChartState.copyWith(isVisible: false);
  } else if (action is UnloadBookAction) {
    return const ActionChartState.initialState();
  }

  return actionChartState;
}
