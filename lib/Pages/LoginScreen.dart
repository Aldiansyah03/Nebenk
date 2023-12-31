// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously, avoid_print

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

  bool isLoading = false;
  bool isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  void submit(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Email atau Password tidak boleh kosong"),
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
      return;
    }
    setState(() {
      isLoading = true;
    });
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
      } else if (e.code == 'invalid-email') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Format Email Salah "),
                content: const Text(
                    "Email yang anda masukan salah, silahkan coba lagi"),
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
                    "Anda telah mencoba login terlalu banyak, silahkan Reset Password Anda"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ResetPasswordPage())));
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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3668B2),
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 350,
                      height: 350,
                      child: Image.asset("assets/NK.png"),
                    ),
                    const Text(
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
                    fillColor: const Color.fromARGB(255, 217, 217, 217),
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
                    fillColor: const Color.fromARGB(255, 217, 217, 217),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                Column(
                  children: [
                    const SizedBox(height: 10),
                    isLoading
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  submit(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF3668B2),
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Login'),
                              ),
                            ],
                          ),
                  ],
                ),
                // const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF3668B2),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Register'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ResetPasswordPage(),
                    ));
                  },
                  style: TextButton.styleFrom(
                    primary: const Color(0xFF3668B2),
                    // onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
