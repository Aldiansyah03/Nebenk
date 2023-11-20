import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  final String driverName;
  final String passengerName;

  StatusPage({required this.driverName, required this.passengerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Pemesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Pemberi Tumpangan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Nama Pemberi Tumpangan: $driverName'),
            // Tambahkan data pemberi tumpangan yang lain di sini sesuai kebutuhan

            SizedBox(height: 20),
            Text(
              'Data Penumpang:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Nama Penumpang: $passengerName'),
            // Tambahkan data penumpang yang lain di sini sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
