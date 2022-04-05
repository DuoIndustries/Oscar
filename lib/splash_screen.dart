import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'models/local_storage.dart';

class SplashScreen extends StatefulWidget{

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Storage _storage = Storage();

  @override
  void initState() {
    super.initState();
    checkLogin();
    }

  void checkLogin() {
    _storage.readData('uid').then((String? value) => {
      if (value == null) {
        Timer(Duration(milliseconds: 1000), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())))
      } else {
        Timer(Duration(milliseconds: 1000), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())))
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/launch_image.png",
                  height: 200.0,
                  width: 200.0,
                ),
              ],
            ),

            CircularProgressIndicator(
              valueColor:  AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            ),
          ],
        ),
      ),
    );
  }
}