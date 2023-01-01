import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'middleware/navigate_middleware.dart';
import 'models/app_state.dart';
import 'reducers/app_state_reducer.dart';

Store<AppState> createStore() {
  return Store<AppState>(
    appStateReducer,
    initialState: const AppState.initialState(),
    middleware: [
      thunkMiddleware,
      navigateMiddleware,
    ],
  );
}
