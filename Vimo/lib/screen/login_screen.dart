import 'package:Vimo/resources/firebase_repo.dart';
import 'package:Vimo/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseRepo _repo = FirebaseRepo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: loginButton(),
    );
  }

  Widget loginButton() {
    return FlatButton(
      padding: EdgeInsets.all(35),
      child: Text(
        "LOGIN",
        style: TextStyle(
            fontSize: 35, fontWeight: FontWeight.w900, letterSpacing: 1.2),
      ),
      onPressed: () => performLogin(),
    );
  }

  void performLogin() {
    _repo.signIn().then((User user) {
      if (user != null) {
        authenticateUser(user);
      } else {
        print("Error!");
      }
    });
  }

  void authenticateUser(User user) {
    _repo.authenticateUser(user).then((isNewUser) {
      if (isNewUser) {
        _repo.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    });
  }
}
