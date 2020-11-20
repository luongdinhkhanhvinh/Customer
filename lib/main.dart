import 'package:flutter/material.dart';
import 'package:fooddelivery/model/account.dart';
import 'package:fooddelivery/route.dart';
import 'package:fooddelivery/config/theme.dart';
import 'package:fooddelivery/ui/login/login.dart';
import 'package:fooddelivery/ui/start/splash.dart';

import 'config/lang.dart';

//
// Theme
//
AppThemeData theme = AppThemeData();
//
// Language data
//
Lang strings = Lang();
//
// Routes
//
AppFoodRoute route = AppFoodRoute();
//
// Account
//
Account account = Account();

void main() {
  theme.init();
  strings.setLang(Lang.english); // set default language - English
  runApp(AppFoodDelivery());
}

class AppFoodDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _theme = ThemeData(
      fontFamily: 'Raleway',
      primarySwatch: theme.primarySwatch,
    );

    if (theme.darkMode) {
      _theme = ThemeData(
        fontFamily: 'Raleway',
        brightness: Brightness.dark,
        unselectedWidgetColor: Colors.white,
        primarySwatch: theme.primarySwatch,
      );
    }

    return MaterialApp(
      title: strings.get(10), // "Food Delivery Flutter App UI Kit",
      debugShowCheckedModeBanner: false,
      theme: _theme,
      initialRoute: '/splash',
      //initialRoute: '/login',
      routes: {
        '/splash': (BuildContext context) => SplashScreen(),
        '/login': (BuildContext context) => LoginScreen(),
      },
    );
  }
}
