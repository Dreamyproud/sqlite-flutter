import 'package:flutter_login/models/user.dart';
import 'dart:async';
import 'package:flutter_login/data/database_helper.dart';

class LoginCtr {
  DatabaseHelper con = new DatabaseHelper();

//Create user
  Future<int> saveUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  Future<User> getLogin(String user, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM user WHERE username = '$user' and password = '$password'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  }
}
