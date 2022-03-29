import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}