import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:practical/common/AppLanguage.dart';
import 'package:practical/common/app_localizations.dart';
import 'package:practical/modules/splash_screen.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'constants/images_path.dart';

void main() async {
  // runApp(const MyApp());

  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  final AppLanguage appLanguage;

  MyApp({required this.appLanguage});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (context) {
        return AppLanguage();
      },
      child: Consumer<AppLanguage>(
        builder: (context, model, child) {
          return MaterialApp(
            locale: model.appLocal,
            supportedLocales: [
              Locale('en', 'US'),
              Locale('hi', ''),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            title: 'Practical Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              // fontFamily: 'PoppinsRegular',
            ),

            // home: AuthScreen(),
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
            //     routes: {//can define but as for static ignore as of now also maintained all screen in app routes },
          );
        },
      ),
    );
  }
}
