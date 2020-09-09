import 'package:flutter_login/services/request/login_request.dart';
import 'package:flutter_login/models/user.dart';

abstract class LoginCallBack {
  void onLoginSuccess(User user);
  void onLoginError(String error);
  void onInsertSuccess(int result);
}

class LoginResponse {
  LoginCallBack _callBack;
  LoginRequest loginRequest = new LoginRequest();
  LoginResponse(this._callBack);

  doLogin(String username, String password) {
    loginRequest
        .getLogin(username, password)
        .then((user) => _callBack.onLoginSuccess(user))
        .catchError((onError) => _callBack.onLoginError(onError.toString()));
  }
  doInsert() {
    loginRequest
        .insertUser()
        .then((result) => _callBack.onInsertSuccess(result))
        .catchError((onError) => _callBack.onLoginError(onError.toString()));
  }
}