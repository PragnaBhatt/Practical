import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/constants/color_constants.dart';
import 'package:practical/constants/images_path.dart';
import 'package:practical/constants/preferences_constants.dart';
import 'package:practical/modules/controllers/common_parm_controller.dart';
import 'package:practical/modules/login/screens/auth_screen.dart.dart';
import 'package:practical/modules/profile/profile.dart';
import 'package:practical/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences _sharedPreferences;

  @override
  void initState() {
    _prefs.then((SharedPreferences sharedPreferences) {
      _sharedPreferences = sharedPreferences;

      Timer(const Duration(seconds: 3), () {
        Get.put<CommnParmController>(CommnParmController(language: 'hi'));
        print('login data....');
        print(_checkIsUserAlreadyLoggedIn);
        if (_checkIsUserAlreadyLoggedIn()) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => Profile_Screen()));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => AuthScreen()));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.colorBlack,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            ImagesPath.splash_bg,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _redirectToDashboard() {
    Get.offAndToNamed(AppRoutes.HOME_SCREEN);
  }

  bool _checkIsUserAlreadyLoggedIn() {
    return _sharedPreferences.containsKey(PreferencesConstants.EMAIL) &&
        _sharedPreferences.containsKey(PreferencesConstants.ISLOGIN);
  }
}
