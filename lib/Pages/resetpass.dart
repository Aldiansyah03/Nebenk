import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nebengk/Pages/LoginScreen.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  String resetStatus = ''; // Menyimpan status reset password

  void resetPassword() async {
    try {
      // Lakukan logika pengiriman tautan reset password di sini
      // Misalnya, Anda dapat menggunakan kode yang telah disediakan sebelumnya
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);

      // Setel status pesan sukses
      setState(() {
        resetStatus = 'Tautan reset password telah dikirim ke email Anda.';
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      
    } on FirebaseAuthException catch (e) {
      // Tangani kesalahan reset password
      setState(() {
        resetStatus = 'Terjadi kesalahan: ${e.code}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Masukkan alamat email Anda untuk reset password:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: resetPassword, // Memanggil fungsi resetPassword
                child: Text('Kirim Tautan Reset Password'),
              ),
              SizedBox(height: 20),
              Text(resetStatus), // Menampilkan pesan status reset password
            ],
          ),
        ),
      ),
    );
  }
}
