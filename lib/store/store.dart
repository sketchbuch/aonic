import 'package:lonewolf_new/store/reducers/app_state_reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'models/app_state.dart';

Store<AppState> createStore() {
  return Store<AppState>(
    appStateReducer,
    initialState: const AppState.initialState(),
    middleware: [
      thunkMiddleware,
    ],
  );
}
