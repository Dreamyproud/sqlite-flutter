import 'package:flutter/material.dart';
import 'package:flutter_login/models/user.dart';
import 'package:flutter_login/pages/home/home.dart';
import 'package:flutter_login/pages/login/inputText.dart';
import 'package:flutter_login/services/response/login_response.dart';
import 'package:flutter_login/utilities/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Login page implements
class LoginPage extends StatefulWidget {
  static const String routeName = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> implements LoginCallBack {
  final formKey = new GlobalKey<FormState>();
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  bool _isLoading = false;
  LoginResponse _response;
  String _username, _password;
  BuildContext _ctx;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  _LoginPageState() {
    _response = new LoginResponse(this);
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response.doLogin(_username, _password);
        //_response.doInsert();
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        _ctx = context;
        Column(
          children: [
            Container(
              width: 130,
              height: 240,
              child: Image(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ],
        );
        var loginBtn = new Container(
          width: 300,
          height: 150,
          child: Column(
            children: [
              Container(
                width: 300,
                height: 40,
                child: RaisedButton(
                    onPressed: _submit,
                    color: Colors.redAccent,
                    elevation: 0,
                    textColor: Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                    child: Text(
                      "LOGIN",
                    )
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 6),
                width: 280,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("Forgot password",
                      style: TextStyle(color: Colors.redAccent, fontSize: 14)),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 170,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      FontAwesomeIcons.facebook,
                      size: 30,
                      color: Colors.redAccent,
                    ),
                    Icon(FontAwesomeIcons.twitter, size: 30, color: Colors.redAccent),
                    Icon(FontAwesomeIcons.github, size: 30, color: Colors.redAccent),
                  ],
                ),
              )
            ],
          )
        );
        var loginForm = new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    width: 130,
                    height: 240,
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 40),
                    height: 40,
                    width: 400,
                    child: Text("¡Bienvenido!",
                        style: TextStyle(fontSize: 30, color: Colors.blueGrey)),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: 300,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputText(
                          onSaved: (val) =>_username = val,
                          iconPath: FontAwesomeIcons.user,
                          placeholder: 'Email',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputText(
                          onSaved: (val) => _password = val,
                          iconPath: FontAwesomeIcons.lock,
                          placeholder: 'Password',
                          typePassword: true,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            loginBtn
          ],
        );
        return new Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomPadding: false,
          body: new Container(
            child: new Center(
              child: loginForm,
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return HomePage(signOut);
        break;
    }
  }

  savePref(int value, String user, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
      preferences.commit();
    });
  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    if (user != null) {
      savePref(1, user.username, user.password);
      _loginStatus = LoginStatus.signIn;
    } else {
      _showSnackBar("El usuario no existe");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void onInsertSuccess(int result) {
    // TODO: implement onInsertSuccess
  }
}
