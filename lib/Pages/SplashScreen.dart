import 'package:flutter/material.dart';
// import 'package:nebengk/Pages/HomePage.dart';
import 'package:nebengk/Pages/LoginScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Nebeng Kampus",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Center(
            child: Text(
              "Going to Campus ITK",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 350,
            height: 350,
            child: Image.asset("assets/NK.png"),
          ),
          SizedBox(height: 50),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Ink(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFF49648D),
              ),
              child: Text(
                "Get Started",
                style: TextStyle(
                  color:
                      Colors.white, // Menggunakan Colors.white untuk warna teks
                  fontSize: 18,
                  fontWeight: FontWeight
                      .bold, // Menggunakan FontWeight.bold untuk ketebalan teks
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
