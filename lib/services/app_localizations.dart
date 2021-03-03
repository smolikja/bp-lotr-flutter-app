import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations get instance => _AppLocalizationsDelegate.instance;

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String languageCode = "en";
    String jsonString = await rootBundle.loadString('assets/localizations/$languageCode.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key, [List<String> params]) {
    String translation = _localizedStrings[key];
    if (params != null && params.isNotEmpty) {
      for (String param in params) {
        if (translation.contains("\$\$")) {
          translation = translation.replaceFirst("\$\$", param);
        }
      }
    }
    return translation;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  static AppLocalizations instance;

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    instance = localizations;
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) {
    return true;
  }
}
