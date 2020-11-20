import 'package:flutter/material.dart';
import 'package:fooddelivery/ui/login/createaccount.dart';
import 'package:fooddelivery/ui/login/forgot.dart';
import 'package:fooddelivery/ui/login/login.dart';
import 'package:fooddelivery/ui/login/sendphone.dart';
import 'package:fooddelivery/ui/login/verifyphone.dart';
import 'package:fooddelivery/ui/main/basket.dart';
import 'package:fooddelivery/ui/main/categoryDetails.dart';
import 'package:fooddelivery/ui/main/delivery.dart';
import 'package:fooddelivery/ui/main/dishesDetails.dart';
import 'package:fooddelivery/ui/main/mainscreen.dart';
import 'package:fooddelivery/ui/main/notification.dart';
import 'package:fooddelivery/ui/main/orderdetails.dart';
import 'package:fooddelivery/ui/main/payment.dart';
import 'package:fooddelivery/ui/main/restaurantDetails.dart';
import 'package:fooddelivery/ui/menu/help.dart';
import 'package:fooddelivery/ui/menu/language.dart';
import 'package:fooddelivery/ui/menu/termofservice.dart';
import 'package:fooddelivery/ui/start/onboard.dart';

class AppFoodRoute{

  Map<String, StatefulWidget> routes = {
    "/onboard" : OnBoardingScreen(),
    "/login" : LoginScreen(),
    "/forgot" : ForgotScreen(),
    "/createaccount" : CreateAccountScreen(),
    "/sendphone" : SendPhoneNumberScreen(),
    "/verifyphone" : VerifyPhoneNumberScreen(),
    "/main" : MainScreen(),
    "/notify" : NotificationScreen(),
    "/language" : LanguageScreen(),
    "/help" : HelpScreen(),
    "/term" : TermOfServiceScreen(),
    "/dishesdetails" : DishesDetailsScreen(),
    "/restaurantdetails" : RestaurantDetailsScreen(),
    "/categorydetails" : CategoryDetailsScreen(),
    "/basket" : BasketScreen(),
    "/delivery" : DeliveryScreen(),
    "/payment" : PaymentScreen(),
    "/orderdetails" : OrderDetailsScreen(),
  };

  MainScreen mainScreen;
  List<StatefulWidget> _stack = List<StatefulWidget>();

  int _seconds = 0;

  disposeLast(){
    if (_stack.isNotEmpty)
      _stack.removeLast();
    _printStack();
  }

  setDuration(int seconds){
    _seconds = seconds;
  }

  pushLanguage(BuildContext _context, Function(String) callback){
    var _screen = LanguageScreen(callback : callback);
    _stack.add(_screen);
    _printStack();
    Navigator.push(
      _context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: _seconds),
        pageBuilder: (_, __, ___) => _screen,
      ),
    );
    _seconds = 0;
  }

  push(BuildContext _context, String name){
    var _screen = routes[name];
    if (name == "/main")
      mainScreen = _screen;
    _stack.add(_screen);
    _printStack();
    Navigator.push(
      _context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: _seconds),
        pageBuilder: (_, __, ___) => _screen,
      ),
    );
    _seconds = 0;
  }

  pushToStart(BuildContext _context, String name) {
    var _screen = routes[name];
    if (name == "/main")
      mainScreen = _screen;
    _stack.clear();
    _stack.add(_screen);
    _printStack();
    Navigator.pushAndRemoveUntil(
        _context,
        PageRouteBuilder(
          transitionDuration: Duration(seconds: _seconds),
          pageBuilder: (_, __, ___) => _screen,
        ),
        (route) =>route == null
    );
    _seconds = 0;
  }

  _printStack(){
    var str = "Screens Stack: ";
    for (var item in _stack)
      str = "$str -> $item";
    print(str);
  }

  pop(BuildContext context){
    Navigator.pop(context);
  }

  popToMain(BuildContext context){
    var _lenght = _stack.length;
    for (int i = 0; i < _lenght-1; i++) {
      pop(context);
    }
  }

}