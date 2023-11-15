import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nebengk/konfirmasi/halamandatapenumpang.dart';

class PemesananKursiPage extends StatelessWidget {
  final String tanggalbatas;
  final String date;
  final String time;
  final String deadline;
  final String seatCount;
  final String details;
  final String cost;
  final String vehicleType;
  final String user;

  PemesananKursiPage({
    required this.tanggalbatas,
    required this.date,
    required this.time,
    required this.deadline,
    required this.seatCount,
    required this.details,
    required this.cost,
    required this.vehicleType,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pemesanan Kursi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildInfoItem("Tanggal Perjalanan", tanggalbatas, Icons.date_range),
            buildInfoItem("Jam", time, Icons.access_time),
            buildInfoItem("Batas Pemesanan", deadline, Icons.timer),
            buildInfoItem("Jumlah Kursi Tersedia", seatCount, Icons.event_seat),
            buildInfoItem("Lokasi", details, Icons.location_on),
            buildInfoItem("Biaya", cost, Icons.attach_money),
            buildInfoItem("Jenis Kendaraan", vehicleType, Icons.directions_car),
            buildInfoItem("Pemberi Tumpangan", user, Icons.person),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tampilkan popup konfirmasi
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Konfirmasi'),
                      content:
                          const Text('Apakah Anda yakin memesan kursi ini?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () async {
                            // Tambahkan logika pemesanan kursi di sini
                            // Anda dapat menggunakan Firebase untuk menyimpan data pemesanan
                            // Misalnya, dapat menggunakan Firestore untuk menyimpan data pemesanan ke koleksi 'bookings'
                            await FirebaseFirestore.instance
                                .collection('bookings')
                                .add({
                              'date': date,
                              'time': time,
                              'seatCount': seatCount,
                              'details': details,
                              'cost': cost,
                              'vehicleType': vehicleType,
                              'user': user,
                            });

                            // Setelah pemesanan berhasil, arahkan ke halaman selanjutnya
                            Navigator.of(context)
                                .pop(); // Tutup dialog konfirmasi
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DataPenumpangPage(
                                    idTrip: "your_trip_id_here", date: date),
                              ),
                            );
                          },
                          child: const Text('Ya'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Pesan Kursi"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoItem(String label, String value, IconData icon) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.blue),
        title: Text("$label: $value"),
      ),
    );
  }
}
