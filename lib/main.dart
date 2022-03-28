import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'pages/login_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}