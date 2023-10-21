import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/profil.png'),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Aldiansyah',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Alamat: Jl.Marsma R iswahyudi, Sungai Nangka rt 10'),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Nomor Telepon: 081649572780'),
                ),
                // Tambahkan info tambahan lainnya sesuai kebutuhan Anda
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Tindakan yang diambil saat tombol "Edit Profil" diklik
            },
            child: Text('Edit Profil'),
          ),
        ],
      ),
    );
  }
}

class ProfilePageScreen extends StatelessWidget {
  const ProfilePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CircleAvatar(
          radius: 100,
          child: Image.asset("assets/icons/profil.png"),
        ),
        const SizedBox(height: 20),
        itemProfile('Nama', 'Muhammad Aldiansyah', CupertinoIcons.person),
        const SizedBox(height: 10),
        itemProfile('Nomor Telepon', '085266127946', CupertinoIcons.phone),
        const SizedBox(height: 10),
        itemProfile('Alamat', 'Sepinggan, Balikpapan', CupertinoIcons.location),
        const SizedBox(height: 10),
        itemProfile('Email', 'aldiansyah@gmail.com', CupertinoIcons.mail),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Tindakan yang diambil saat tombol "Edit Profil" diklik
            },
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
            child: const Text('Edit Profil'),
          ),
        ),
      ],
    );
  }

  Widget itemProfile(String title, String subtitle, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: const Color.fromARGB(255, 50, 47, 135).withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icon),
      ),
    );
  }
}
