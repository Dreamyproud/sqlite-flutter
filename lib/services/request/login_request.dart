import 'dart:async';
import 'package:flutter_login/models/user.dart';
import 'package:flutter_login/data/CtrQuery/login_ctr.dart';

class LoginRequest {
  LoginCtr con = new LoginCtr();

  Future<User> getLogin(String username, String password) {
    var result = con.getLogin(username, password);
    return result;
  }

  Future<int> insertUser() {
    User user = new User("danigarcia_1@hotmail.com", "1234");
    var result = con.saveUser(user);
    return result;
  }
}
