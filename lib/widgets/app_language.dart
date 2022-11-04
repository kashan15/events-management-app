import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class AppLanguage extends BaseViewModel {
  Locale? appLocale;

  Locale get appLocal => appLocale ?? Locale("en");
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      appLocale = Locale('es');
      print(appLocale);
      //return appLocale;
    }
    appLocale = Locale(prefs.getString('language_code')??'en');
    print(appLocale);
    notifyListeners();
    //return appLocale;
  }


  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    // if (_appLocale == type) {
    //   return;
    // }
    if (type == Locale("es")) {
      appLocale = Locale("es");
      await prefs.setString('language_code', 'es');
      //await prefs.setString('countryCode', '');
    } else {
      appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      // await prefs.setString('countryCode');
    }
    notifyListeners();
  }
}