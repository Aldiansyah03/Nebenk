import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebengk/Pages/Beritumpangan1.dart'; // Sesuaikan dengan nama file yang sesuai

class BeriTumpangan extends StatefulWidget {
  @override
  _BeriTumpanganState createState() => _BeriTumpanganState();
}

class _BeriTumpanganState extends State<BeriTumpangan> {
  TextEditingController jenisKendaraanController = TextEditingController();
  TextEditingController jumlahKursiController = TextEditingController();
  TextEditingController biayaPerjalananController = TextEditingController();
  TextEditingController detailPerjalananController = TextEditingController();
  TextEditingController batasWaktuPemesananController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: Color(0xFF3668B2),
        title: Text("NeBengK"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Implementasi tindakan ketika tombol pesan ditekan
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF3668B2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    // Tambahkan foto profil pengguna di sini
                    // Misalnya, jika foto profil tersedia di assets, Anda bisa menggunakan:
                    // backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nama Pengguna',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Email Pengguna',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Akun'),
              onTap: () {
                // Aksi yang ingin Anda lakukan ketika "Akun" diklik
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Pusat Bantuan'),
              onTap: () {
                // Aksi yang ingin Anda lakukan ketika "Pusat Bantuan" diklik
              },
            ),
            ListTile(
              leading: Icon(Icons.support),
              title: Text('Dukungan'),
              onTap: () {
                // Aksi yang ingin Anda lakukan ketika "Dukungan" diklik
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Aksi yang ingin Anda lakukan ketika "Logout" diklik
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20), // Spasi antara header dan form

              // Form untuk memasukkan data perjalanan
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: jenisKendaraanController,
                      decoration: InputDecoration(labelText: 'Jenis Kendaraan'),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: jumlahKursiController,
                      decoration: InputDecoration(labelText: 'Jumlah Kursi'),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: biayaPerjalananController,
                      decoration: InputDecoration(labelText: 'Biaya Perjalanan'),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: detailPerjalananController,
                      decoration: InputDecoration(labelText: 'Detail Perjalanan'),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: batasWaktuPemesananController,
                      decoration: InputDecoration(labelText: 'Batas Waktu Pemesanan'),
                    ),
                    SizedBox(height: 20),

                    // Tombol "Buat Perjalanan"
                    ElevatedButton(
                      onPressed: () {
                        // Tampilkan pemberitahuan
                        final snackBar = SnackBar(
                          content: Text('Perjalanan Berhasil dibuat. Silahkan tunggu untuk pengajuan dari pengguna lain.'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        // Berpindah ke halaman Beritumpangan1 dengan data yang dikirimkan
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Beritumpangan1(
                              jenisKendaraan: jenisKendaraanController.text,
                              jumlahKursi: jumlahKursiController.text,
                              biayaPerjalanan: biayaPerjalananController.text,
                              detailPerjalanan: detailPerjalananController.text,
                              batasWaktuPemesanan: batasWaktuPemesananController.text,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF49648D),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          'Buat perjalanan',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
