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
            _buildProfileitem('Nama', nama, CupertinoIcons.person),
            const SizedBox(height: 10),
            _buildProfileitem(
                'Nomor Telepon', nomor_telepon, CupertinoIcons.phone),
            const SizedBox(height: 10),
            _buildProfileitem('Alamat', alamat, CupertinoIcons.location),
            const SizedBox(height: 10),
            _buildProfileitem('Email', email, CupertinoIcons.mail),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15)),
                  child: const Text('Edit Profil')),
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
