import 'package:flutter/material.dart';
import 'package:nebengk/Pages/HomePage.dart';
import 'package:nebengk/Pages/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => SplashScreen(),
        "/HomePage": (context) => HomePage(),
      },
    );
  }
}