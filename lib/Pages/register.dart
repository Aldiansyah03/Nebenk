// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nebengk/Pages/LoginScreen.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        await userCredential.user!.sendEmailVerification();

        // Menampilkan PopUp setelah pendaftaran berhasil.
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Verifikasi Email"),
                content: Text(
                    "Email untuk verifikasi akun telah dikirimkan ke alamat yang anda daftarkan. silahkan lakukan verifikasi,kemudian login dengan akun anda."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('Tutup'),
                  ),
                ],
              );
            });

        // Navigasi ke halaman masuk setelah pendaftaran berhasil
      } on FirebaseAuthException catch (e) {
        // Penanganan kesalahan saat mendaftar
        if (e.code == 'email-already-in-use') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Akun sudah ada'),
                content: const Text(
                    'Email ini sudah terdaftar. Silakan gunakan email lain atau masuk dengan email ini.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Tutup'),
                  ),
                ],
              );
            },
          );
        } else {
          // Penanganan kesalahan lainnya
          print('Kesalahan saat mendaftar: ${e.message}');
        }
      } catch (e) {
        // Penanganan kesalahan lainnya
        print('Kesalahan saat mendaftar: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Silahkan Mendaftar Akun',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Masukkan Email Anda',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Buat Password Anda',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _registerUser,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                ),
                child: const Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
