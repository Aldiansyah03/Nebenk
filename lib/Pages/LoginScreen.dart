import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nebengk/Pages/HomePage.dart';
import 'package:nebengk/Pages/register.dart';
import 'package:nebengk/Pages/resetpass.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void submit(BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (credential.user!.emailVerified) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("akun anda belum diverifikasi"),
              );
            });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-login-credentials') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Kesalahan Login"),
                content: const Text(
                    "Email atau Password yang anda masukan salah, silahkan coba lagi"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Tutup"),
                  )
                ],
              );
            });
      } else if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Email Tidak Terdaftar"),
              content: const Text(
                  "Email yang anda masukan tidak terdaftar, silahkan daftar terlebih dahulu"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Tutup"),
                )
              ],
            );
          },
        );
        print('Email tidak ditemukan. Silakan daftar terlebih dahulu.');
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Kata Sandi Salah"),
              content: const Text(
                  "Kata Sandi yang anda masukan salah, silahkan coba lagi"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Tutup'),
                ),
              ],
            );
          },
        );
        print('Kata sandi salah. Silakan coba lagi.');
      } else if (e.code == 'too-many-requests') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Terlalu Banyak Percobaan"),
                content: const Text(
                    "Anda telah mencoba login terlalu banyak, silahkan coba lagi nanti"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Tutup'),
                  ),
                ],
              );
            });
      } else {
        print('Error : ${e.code} - ${e.message}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Silahkan Login Untuk Melanjutkan",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Masukkan email',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: "Masukkan password",
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    submit(context);
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()));
                  },
                  child: const Text('Register'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ResetPasswordPage(),
                    ));
                  },
                  child: const Text('Lupa Kata Sandi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
