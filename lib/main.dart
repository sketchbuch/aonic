import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'action_chart/ac.dart';
import 'action_chart/data/action_chart_data.dart';
import 'config/config.dart';
import 'i18n/_generated_/translations.g.dart';
import 'routes/generate_main_route.dart';
import 'routes/routes.dart';
import 'store/redux/models/app_state.dart';
import 'store/redux/redux.dart';
import 'theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  setupConfig();
  setupActionChart('lw', actionChart, actionChartData);

  final store = createStore();
  runApp(TranslationProvider(child: App(store)));
}

class App extends StatelessWidget {
  final Store<AppState> store;
  final trans = t.common;

  App(this.store, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: homeRoute,
        // TODO - Put back to dynamic
        // locale: TranslationProvider.of(context).flutterLocale,
        locale: const Locale('en'),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        navigatorKey: mainNav,
        onGenerateRoute: generateMainRoute,
        supportedLocales: LocaleSettings.supportedLocales,
        theme: getTheme(),
        title: trans.appTitle,
      ),
    );
  }
}
