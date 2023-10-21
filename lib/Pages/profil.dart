import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
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

          // Nama Pengguna
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
                  title: Text('Alamat: Jl.Marsma R iswahyudi,Sungai Nangka rt 10'),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Nomor Telepon: 081649572780'),
                ),
                // Tambahkan info tambahan lainnya sesuai kebutuhan Anda
              ],
            ),
          ),

          // Tombol Edit Profil
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
