import 'package:flutter/material.dart';

class PemberiTumpanganPage extends StatelessWidget {
  final List<String> bookedSeats; // Ganti dengan tipe data yang sesuai

  PemberiTumpanganPage({required this.bookedSeats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pemberi Tumpangan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Daftar Pemesan Kursi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: bookedSeats.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Pemesan: ${bookedSeats[index]}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Implementasi logika konfirmasi
                        _confirmBooking(context, bookedSeats[index]);
                      },
                      child: Text('Konfirmasi'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi
  Future<void> _confirmBooking(BuildContext context, String pemesan) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pemesanan'),
          content: Text('Konfirmasi pemesanan dari $pemesan?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Implementasi logika konfirmasi di sini
                // Misalnya, mengubah status pemesanan atau yang lainnya
                // Setelah itu, Anda bisa memperbarui UI atau menavigasi ke halaman lain
                Navigator.of(context).pop();
                // Tambahkan logika konfirmasi di sini
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
