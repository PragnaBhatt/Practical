import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/modules/login/screens/auth_screen.dart.dart';
import 'package:practical/modules/profile/profile.dart';
import 'package:practical/modules/splash_screen.dart';
import 'package:practical/routes/app_routes.dart';


class AppScreens {
  static var list = [
    GetPage(
      name: AppRoutes.SPLASH_SCREEN,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.HOME_SCREEN,
      page: () => Profile_Screen(),
    ),
    GetPage(
      name: AppRoutes.LOGIN_SCREEN,
      page: () => AuthScreen(),
    ),
   
    //ManagerInfoCardDropDown
  ];
}
