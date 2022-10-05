import 'package:redux/redux.dart';

import '../actions/actions.dart';
import '../models/app_state.dart';

dynamic navigateMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is NavigateAction) {
    print('### middleware: "${action.route}"');
    action.navigator.currentState!.pushNamed(action.route);
  }

  return next(action);
}
