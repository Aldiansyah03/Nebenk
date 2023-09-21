import 'package:flutter/material.dart';
import 'package:nebengk/Pages/HomePage.dart'; // Gantilah 'your_app_name' dengan nama yang sesuai

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9), // Menggunakan format warna yang valid
      body: Center( // Menggunakan 'Center' dengan 'C' besar
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "Images/Nk.png",
              height: 100,
            ), 
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                "Going To Kampus ",
                style: TextStyle(
                  color: Colors.black, // Menggunakan Colors.black untuk warna hitam
                  fontSize: 30, // Menggunakan 'fontSize' dengan 'F' besar
                  fontWeight: FontWeight.bold, // Menggunakan 'FontWeight.bold' dengan 'F' dan 'W' besar
                ),
              ),
            ),
            SizedBox(height: 50),

            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
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
                    color: Colors.white, // Menggunakan Colors.white untuk warna teks
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // Menggunakan FontWeight.bold untuk ketebalan teks
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
