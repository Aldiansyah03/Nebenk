// ignore_for_file: non_constant_identifier_names, sort_child_properties_last, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User? currentUser;
  String? nama = '';
  String? nomor_telepon = '';
  String? alamat = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          // final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        setState(() {
          nama = userData['nama'];
          nomor_telepon = userData['nomor_telepon'];
          alamat = userData['alamat'];
        });
      }
    }
  }

  Future<void> saveUserData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        Map<String, dynamic> userData = {
          'nama': nama,
          'nomor_telepon': nomor_telepon,
          'alamat': alamat,
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update(userData)
            .then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data Berhasil diubah!!')));
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gagal mengubah data!!')));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal mengubah data!!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        title: const Text("Edit Profil"),
        backgroundColor: const Color(0xFF3668B2),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            )
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'assets/profil.png'), // Ganti dengan path gambar akun
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: Colors.blue,
                          ),
                          child: const Icon(Icons.edit, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField("Nama Lengkap", nama, CupertinoIcons.person,
                    (value) {
                  nama = value;
                }),
                _buildTextField(
                    "Nomor Telepon", nomor_telepon, CupertinoIcons.phone,
                    (value) {
                  nomor_telepon = value;
                }),
                _buildTextField("Alamat", alamat, CupertinoIcons.location,
                    (value) {
                  alamat = value;
                }),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context); // Mengembalikan data awal
                      },
                      child: const Text(
                        "BATAL",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.black,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        saveUserData();
                      },
                      child: const Text(
                        "SIMPAN",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF3668B2),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String labeltext,
    String? value,
    IconData icon,
    void Function(String?)? onSaved,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        onSaved: onSaved,
        initialValue: value,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labeltext,
          hintText: "Masukkan $labeltext",
          filled: true,
          fillColor: const Color.fromARGB(255, 217, 217, 217),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
