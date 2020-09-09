import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/pages/login/loginScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/homePage";
  final VoidCallback signOut;
  HomePage(this.signOut);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text("Bienvenido"),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              width: 400,
              height: 120,
              child: Text(
                "Nos da gusto verte de nuevo, nuestro sitio se encuentra en construcción",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 400,
              height: 250,
              child: Image(
                image: AssetImage(
                  "assets/images/build.jpg",
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.redAccent),
              accountName: Text("Angela Garcia"),
              currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? new Color(0xFF0062ac)
                          : Colors.white,
                  child: Image(
                    image: AssetImage(
                      "assets/images/user-avatar.png",
                    ),
                  )),
            ),
            ListTile(
                title: Text("Perfil"),
                leading: Icon(FontAwesomeIcons.houseUser)),
            ListTile(
                onTap: () {
                  signOut();
                },
                title: Text("Cerrar sesión"),
                leading: Icon(FontAwesomeIcons.signOutAlt)),
          ],
        )));
  }
}
