import 'package:flutter/material.dart';
import 'package:investment/core/config/app_routes.dart';
import 'package:investment/core/localization/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp.router(
      title: 'Investment App',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData.light(),
      locale: Locale('en'), // Default language
      supportedLocales: [
        Locale('en', ''), // English
        Locale('ar', ''), // Arabic
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
