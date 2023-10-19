import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(15)),
              child: const Text('Edit Profil')),
        )
      ],
    ));
  }

  itemProfile(String title, String subtitle, IconData icon) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Color.fromARGB(255, 50, 47, 135).withOpacity(.2),
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
