import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/modules/controllers/common_parm_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale;
  fetchLocale() async {
    // var prefs = await SharedPreferences.getInstance();
    // if (prefs.getString('language_code') == null) {
    _appLocale = Locale('hi');
    // return Null;
    // }
    // _appLocale = Locale(prefs.getString('language_code').toString());
    return Null;
  }

  void changeLanguage(Locale type) async {
    print("data===>> ");
    print("this is type...$type");
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
     if (type == Locale("hi")) {
      _appLocale = Locale("hi");
      await prefs.setString('language_code', 'hi');
      await prefs.setString('countryCode', '');
      print('working yet');
      Get.put<CommnParmController>(CommnParmController(language: 'hi'));
    } else if (type == Locale("en")) {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
      print('working yet EN');
      Get.put<CommnParmController>(CommnParmController(language: 'hi'));
    }

    // else {
    //   _appLocale = Locale("en");
    //   await prefs.setString('language_code', 'en');
    //   await prefs.setString('countryCode', 'US');
    //   Get.put<CommnParmController>(CommnParmController(language: 'en'));
    //         print('working yet');

    // }
    notifyListeners();
  }
}
