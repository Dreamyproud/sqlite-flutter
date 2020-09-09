
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/pages/login/inputText.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


/// form for login user and elements UI
class FormLogin extends StatefulWidget {
  FormLogin({Key key}) : super(key: key);
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formkey = GlobalKey<FormState>();
  var _email = '', _password = '';
  bool isLoggIn = false;

  _submit() async {
    final isValid = _formkey.currentState.validate();
    if (isValid) {

     // await _authAPI.login(context, email: _email, password: _password);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Form(
        key: _formkey,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  InputText(
                    iconPath: FontAwesomeIcons.envelope,
                    placeholder: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.contains('@') && value.contains('.')) {
                        _email = value;
                        return null;
                      }
                      return "Correo no valido";
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputText(
                    iconPath: FontAwesomeIcons.lock,
                    placeholder: 'Password',
                    typePassword: true,
                    validator: (value) {
                      if (value.isNotEmpty && !value.contains(" ")) {
                        _password = value;
                        return null;
                      }
                      return "La contraseña no puede estar vacia";
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                   RaisedButton(
                     onPressed: _submit(),
                      child: Text("Login"),
                  ),
                  SizedBox(
                    height: 10
                  ),
                  InkWell(
                      child: Text('He olvidado mi contraseña',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Color(0xFFFF006A))),
                      onTap: () {}
                          ),
                  SizedBox(
                    height: 10
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showMessage(String message) {
    setState(() {
      // _message = message;
    });
  }

  void onLoginStatusChange(bool isLogging) {
    setState(() {
      this.isLoggIn = isLogging;
    });
  }
}
