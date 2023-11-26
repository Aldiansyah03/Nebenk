import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KonfirmasiPenumpangPage extends StatelessWidget {
  final String idTrip; // ID perjalanan yang harus disesuaikan
  final String date; // Tambahkan parameter lain jika diperlukan

  KonfirmasiPenumpangPage({required this.idTrip, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3668B2),
        title: const Text("Konfirmasi Penumpang"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('datapenumpang')
            .where('idTrip', isEqualTo: idTrip)
            .where('date', isEqualTo: date)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final passengers = snapshot.data!.docs;

          if (passengers.isEmpty) {
            return const Center(
              child: Text('Tidak ada penumpang untuk dikonfirmasi.'),
            );
          }

          return ListView.builder(
            itemCount: passengers.length,
            itemBuilder: (context, index) {
              final passenger = passengers[index];
              final data = passenger.data() as Map<String, dynamic>;

              return Card(
                elevation: 2,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text("Nama: ${data['nama']}"),
                  subtitle: Text(
                      "Telepon: ${data['noTelepon']} | Titik Jemput: ${data['titikJemput']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          // Tambahkan logika konfirmasi setuju di sini
                          // Misalnya, Anda dapat memperbarui status penumpang menjadi 'setuju' pada Firestore
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          // Tambahkan logika konfirmasi tidak setuju di sini
                          // Misalnya, Anda dapat menghapus data penumpang dari Firestore
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
