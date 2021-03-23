import 'dart:async';
import 'package:FilmInn/Config/config.dart';
import 'package:FilmInn/Pages/Authentication%20Pages/login.dart';
import 'package:FilmInn/Pages/Authentication%20Pages/register.dart';
import 'package:FilmInn/Widgets/logo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'Pages/Main Pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FilmInn.auth = FirebaseAuth.instance;
  FilmInn.sharedPreferences = await SharedPreferences.getInstance();
  FilmInn.firestore = FirebaseFirestore.instance;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  @override
  void initState() {
    super.initState();

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      
      Fluttertoast.showToast(
          msg: message['notification']['title'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(0xff484dff),
          textColor: Colors.white,
          fontSize: 16.0);

      /*final snackbar = CustomSnackBar.info(
        message: message['notification']['title'],
        backgroundColor: Colors.blue,
      );
      showTopSnackBar(context, snackbar);*/
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Film Inn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    displaySplash();
  }

  displaySplash() {
    Timer(Duration(seconds: 2), () async {
      if (await FilmInn.auth.currentUser != null) {
        Route route = MaterialPageRoute(builder: (_) => Home());
        Navigator.pushReplacement(context, route);
      } else {
        Route route = MaterialPageRoute(builder: (_) => Home());
        Navigator.pushReplacement(context, route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: SizedBox(width: 133.1, height: 56.5, child: Logo())),
    );
  }
}
