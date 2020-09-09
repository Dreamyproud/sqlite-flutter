import 'package:flutter/cupertino.dart';
import 'package:flutter_login/pages/home/home.dart';
import 'package:flutter_login/pages/login/loginScreen.dart';

class Routes {
  //module login
  static const String login = LoginPage.routeName;
  static const String homePage = HomePage.routeName;
  static getRouters(BuildContext context) {
    return {
      login: (context) => LoginPage(),
      //homePage: (context) => HomePage(),
    };
  }
}