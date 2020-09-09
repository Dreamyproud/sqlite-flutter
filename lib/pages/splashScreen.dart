import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/pages/login/loginScreen.dart';
import 'package:flutter_login/utilities/constants.dart';
import 'package:flutter_login/utilities/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLogin = false;

  @override
  void initState() {
    _checkLogin();
    super.initState();
  }

  _checkLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = (prefs.get('isLogin')??false);
    setState(() {
      _isLogin = isLogin;
    });
    if(_isLogin == false){
      startTimerLogin();
    } else {
      startTimerHome();
    }
    print('prefs $isLogin');
  }

  startTimerLogin() async {
    var duration = Duration(seconds: 4);
    return Timer(duration, routeLogin);
  }

  routeLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => LoginPage()
    ));
  }

  startTimerHome() async {
    var duration = Duration(seconds: 4);
    return Timer(duration, routeHome);
  }

  routeHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginPage()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 200,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20)
                ),
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 1,
                )
              ],
            )
        ));
  }
}
