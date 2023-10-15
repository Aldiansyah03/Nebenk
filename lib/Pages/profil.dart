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
          // Bagian Foto Profil
          Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/profile_image.jpg'), // Ganti dengan path gambar profil
              ),
            ),
          ),
          SizedBox(height: 20.0),

          // Nama Pengguna
          Text(
            'Nama Pengguna',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),

          // Info Tambahan (Misalnya: Alamat, Nomor Telepon, dll.)
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Alamat: Jl. Contoh No. 123'),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Nomor Telepon: +1234567890'),
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
