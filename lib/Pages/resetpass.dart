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
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);

      // Setel status pesan sukses
      setState(() {
        resetStatus = 'Tautan reset password telah dikirim ke email Anda.';
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
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
        title: const Text('Reset Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Masukkan alamat email Anda untuk reset password:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Masukkan email Anda',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: resetPassword, // Memanggil fungsi resetPassword
                child: const Text('Kirim Tautan Reset Password'),
              ),
              const SizedBox(height: 20),
              Text(resetStatus), // Menampilkan pesan status reset password
            ],
          ),
        ),
      ),
    );
  }
}
