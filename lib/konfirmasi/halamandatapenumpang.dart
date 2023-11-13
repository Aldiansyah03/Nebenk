import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataPenumpangPage extends StatefulWidget {
  final String idTrip;
  final String date; // Add any other necessary parameters

  DataPenumpangPage(
      {required this.idTrip,
      required this.date}); // Add other necessary parameters

  @override
  _DataPenumpangPageState createState() => _DataPenumpangPageState();
}

class _DataPenumpangPageState extends State<DataPenumpangPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController noTeleponController = TextEditingController();
  TextEditingController titikJemputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Penumpang"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: noTeleponController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Nomor Telepon'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: titikJemputController,
              decoration: InputDecoration(labelText: 'Titik Jemput'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Validasi data
                if (namaController.text.isEmpty ||
                    noTeleponController.text.isEmpty ||
                    titikJemputController.text.isEmpty) {
                  // Tampilkan pesan error jika ada field yang kosong
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Mohon isi semua data'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }

                // Simpan data penumpang ke Firebase
                await FirebaseFirestore.instance
                    .collection('datapenumpang')
                    .add({
                  'idTrip': widget.idTrip,
                  'date': widget.date, // Add other necessary parameters
                  'nama': namaController.text,
                  'noTelepon': noTeleponController.text,
                  'titikJemput': titikJemputController.text,
                });

                // Setelah data berhasil disimpan, tampilkan snackbar sebagai umpan balik
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Data penumpang berhasil disimpan'),
                    duration: Duration(seconds: 2),
                  ),
                );

                // Bersihkan input field setelah penyimpanan berhasil
                namaController.clear();
                noTeleponController.clear();
                titikJemputController.clear();
              },
              child: Text("Simpan Data Penumpang"),
            ),
          ],
        ),
      ),
    );
  }
}
