
import 'package:flutter/material.dart';

import 'detail_penumpang.dart';


class PemesananKursiPage extends StatelessWidget {
  final String tanggal;
  final String jam;
  final int jumlahKursi;
  final String lokasi;
  final String pemberiTumpangan;

  PemesananKursiPage({
    required this.tanggal,
    required this.jam,
    required this.jumlahKursi,
    required this.lokasi,
    required this.pemberiTumpangan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: Color(0xFF3668B2),
        title: Text("Detail Pemesanan"),
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              // Implementasi tindakan ketika tombol pesan ditekan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Detail", style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.directions_car, size: 50.0),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/driver_image.jpg'), // Ganti dengan path gambar driver
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text("Nama Driver", style: TextStyle(fontSize: 16.0)),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20.0),
                Text("4.5", style: TextStyle(fontSize: 16.0)),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("10 Sep - 10.00", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("$jumlahKursi kursi", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.location_on, size: 20.0),
                Text("Sepinggan", style: TextStyle(fontSize: 16.0)),
              ],
            ),
            SizedBox(height: 10.0),
            Divider(),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.location_on, size: 20.0),
                Text("ITK", style: TextStyle(fontSize: 16.0)),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF49648D), // Warna biru
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.directions_car, size: 20.0, color: Colors.white),
                      Text("   mobilio", style: TextStyle(fontSize: 16.0, color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Icon(Icons.error_outline, size: 20.0, color: Colors.white),
                  Text("   Perjalanan: Start dari lampu merah bandara, lewat lampu merah gedung olahraga, lewat grand city lanjut ITK",style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet, size: 20.0, color: Colors.white),
                      Text("   Free", style: TextStyle(fontSize: 16.0, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            
            // Bagian yang ditambahkan
            SizedBox(height: 20.0),

            // Bagian 1 - Penumpang dengan latar belakang putih
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.people, size: 20.0),
                      Text(" Penumpang", style: TextStyle(fontSize: 16.0)),
                      SizedBox(width: 10.0),
                      InkWell(
                        onTap: () {
                          // Tindakan yang diambil saat teks "Lihat" diklik
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailPenumpang()), // Mengarahkan ke halaman DetailPenumpang
                          );
                        },
                        child: Text("Lihat", style: TextStyle(fontSize: 16.0, color: Colors.blue)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),

            // Bagian 2 - Review dengan latar belakang putih
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.people, size: 20.0),
                      Text(" Review", style: TextStyle(fontSize: 16.0)),
                      SizedBox(width: 10.0),
                      InkWell(
                        onTap: () {
                          // Tindakan yang diambil saat teks "Lihat semua" diklik
                        },
                        child: Text("Lihat semua", style: TextStyle(fontSize: 16.0, color: Colors.blue)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),

            // Bagian 3 - Data Review dengan latar belakang putih
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Foto orang dengan tampilan dalam linkaran
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/user_image.jpg'), // Ganti dengan path gambar user
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nama User", style: TextStyle(fontSize: 16.0)),
                          Text("Tanggal Review", style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  // Komentar Review
                  Text(
                    "Ini adalah komentar dari user tentang pengalaman mereka.",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Tindakan yang diambil saat tombol Pesan Kursi ditekan
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailPenumpang ()), // Mengarahkan ke halaman DetailPenumpang
          );
        },
        label: Text("Pesan Kursi"),
        backgroundColor: Color(0xFF49648D), 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
