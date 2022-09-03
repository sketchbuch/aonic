import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'i18n/_generated_/translations.g.dart';
import 'pages/home_page.dart';
import 'store/models/app_state.dart';
import 'store/reducers/app_state_reducer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  final store = Store<AppState>(appStateReducer, initialState: const AppState.initialState());

  runApp(TranslationProvider(child: App(store)));
}

class App extends StatelessWidget {
  final Store<AppState> store;

  const App(this.store, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trans = t.common; // get translation

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(title: trans.title),
        locale: TranslationProvider.of(context).flutterLocale,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: LocaleSettings.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        title: trans.appTitle,
      ),
    );
  }
}
