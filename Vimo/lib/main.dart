import 'package:Vimo/resources/firebase_repo.dart';
import 'package:Vimo/screen/home_screen.dart';
import 'package:Vimo/screen/login_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    FirebaseRepo _repo = FirebaseRepo();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Vimo",
        home: FutureBuilder(
            future: _repo.getCurrentUser(),
            builder: (context, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                return HomeScreen();
              } else {
                return LoginScreen();
              }
            }));
  }
}
