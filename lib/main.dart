import 'package:flutter/material.dart';
import 'package:oscar/pages/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.greenAccent
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}