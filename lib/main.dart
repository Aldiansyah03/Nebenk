import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nebengk/Pages/LoginScreen.dart';
import 'package:nebengk/Pages/SplashScreen.dart';
import 'package:nebengk/Pages/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => SplashScreen(),
        "/LoginScreen": (context) => LoginPage(),
      },
    );
  }
}