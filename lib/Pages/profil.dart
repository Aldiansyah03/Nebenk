// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebengk/Pages/profiledit.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser;
  String nama = '';
  String nomor_telepon = '';
  String email = '';
  String alamat = '';

  @override
  void initState() {
    super.initState();
    // user = FirebaseAuth.instance.currentUser;
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
          email = userData['email'];
          alamat = userData['alamat'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFD9D9D9),
        appBar: AppBar(
          title: const Text('Profil'),
          backgroundColor: const Color(0xFF3668B2),
        ),
        body: ListView(
          children: [
            CircleAvatar(
              radius: 100,
              child: currentUser?.photoURL != null
                  ? Image.network(currentUser!.photoURL!)
                  : const Icon(Icons.person),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildProfileitem('Nama', nama, CupertinoIcons.person),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildProfileitem(
                  'Nomor Telepon', nomor_telepon, CupertinoIcons.phone),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  _buildProfileitem('Alamat', alamat, CupertinoIcons.location),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildProfileitem('Email', email, CupertinoIcons.mail),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF3668B2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('Edit Profil')),
              ),
            )
          ],
        ));
  }

  Widget _buildProfileitem(String title, String subtitle, IconData icon) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: const Color.fromARGB(255, 50, 47, 135).withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icon),
      ),
    );
  }
}
