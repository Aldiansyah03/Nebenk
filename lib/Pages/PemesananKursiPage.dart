import 'package:flutter/material.dart';

class PemesananKursiPage extends StatelessWidget {
  final String vehicleType;
  final String seatCount;
  final String cost;
  final String details;
  final String deadline;
  final String date;
  final String time;
  final String user;

  PemesananKursiPage({
    required this.vehicleType,
    required this.seatCount,
    required this.cost,
    required this.details,
    required this.deadline,
    required this.date,
    required this.time,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pemesanan Kursi'),
        backgroundColor:
            Colors.blue, // Ganti warna latar belakang AppBar sesuai tema Anda
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display relevant information with a more appealing style
            _buildInfoCard('Nama Pengemudi', user),
            _buildInfoCard('Tanggal', date),
            _buildInfoCard('Jam', time),
            _buildInfoCard('Jumlah Kursi', seatCount),
            _buildInfoCard('Lokasi', details),

            // Add additional widgets for seat booking
            SizedBox(height: 20),
            Text(
              'Pilih Kursi Anda',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Add your seat booking widgets here

            ElevatedButton(
              onPressed: () {
                // Implement the logic for seat booking
                // Navigate to the confirmation or payment screen
              },
              child: Text('Pesan Kursi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
