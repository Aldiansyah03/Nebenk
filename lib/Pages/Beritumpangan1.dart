import 'package:flutter/material.dart';

// import 'package:nebengk/Pages/detail_penumpang.dart';
class Beritumpangan1 extends StatelessWidget {
  final String jenisKendaraan;
  final String jumlahKursi;
  final String biayaPerjalanan;
  final String detailPerjalanan;
  final String batasWaktuPemesanan;
  final String tanggalPerjalanan;
  final String jamKeberangkatan;

  Beritumpangan1({
    required this.jenisKendaraan,
    required this.jumlahKursi,
    required this.biayaPerjalanan,
    required this.detailPerjalanan,
    required this.batasWaktuPemesanan,
    required this.tanggalPerjalanan,
    required this.jamKeberangkatan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3668B2),
        title: const Text("Detail Perjalanan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              // Implementasi tindakan ketika tombol pesan ditekan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Bagian 1 - Foto Akun dalam lingkaran dan nama
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/profil.png'), // Ganti dengan path gambar driver
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        "Aldiansyah                                            ",
                        style: TextStyle(fontSize: 16.0)),
                    Text("Biaya $batasWaktuPemesanan",
                        style: const TextStyle(
                            fontSize: 14.0, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            // Bagian 1b - Gambar Motor/Mobil dan Info Tanggal, Jam, dan Jumlah Kursi
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "$tanggalPerjalanan - $jamKeberangkatan - $jumlahKursi kursi",
                        style: const TextStyle(fontSize: 16.0))
                  ],
                ),
                Icon(
                  jenisKendaraan == "     Mobil"
                      ? Icons.directions_car
                      : Icons.motorcycle,
                  size: 40.0,
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Bagian 2 - Titik Awal Keberangkatan dan Tujuan
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bagian 2a - Titik Awal Keberangkatan
                Column(
                  children: [
                    Text("Titik Awal Keberangkatan",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Icon(Icons.location_on, size: 10.0),
                  ],
                ),
                // Bagian 2b - Titik Tujuan
                Column(
                  children: [
                    Text("Titik Tujuan",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Icon(Icons.location_on, size: 10.0),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Bagian 3 - Info Pengemudi dan Kendaraan
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        jenisKendaraan == "Mobil"
                            ? Icons.directions_car
                            : Icons.motorcycle,
                        size: 20.0,
                        color: Colors.blue,
                      ),
                      Text("   $biayaPerjalanan",
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.blue)),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.error_outline,
                          size: 20.0, color: Colors.blue),
                      Text(
                        "   $detailPerjalanan",
                        style:
                            const TextStyle(fontSize: 16.0, color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
