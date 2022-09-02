import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'i18n/_generated_/translations.g.dart';
import 'pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  runApp(TranslationProvider(child: const App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trans = t.common; // get translation

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(title: trans.title),
      locale: TranslationProvider.of(context).flutterLocale,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: LocaleSettings.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: trans.appTitle,
    );
  }
}
