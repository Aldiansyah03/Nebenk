import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nebengk/Pages/HomePage.dart';
import 'package:nebengk/Pages/statuspemesanan.dart';

enum StatusPemesanan { menunggu, diterima, ditolak }

class PemesananKursiPage extends StatefulWidget {
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
  _PemesananKursiPageState createState() => _PemesananKursiPageState();
}

class _PemesananKursiPageState extends State<PemesananKursiPage> {
  late StatusPemesanan statusPemesanan = StatusPemesanan.menunggu;

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
            buildInfoItem(
                "Tanggal Perjalanan", widget.tanggalbatas, Icons.date_range),
            buildInfoItem(
                "Jumlah Kursi Tersedia", widget.seatCount, Icons.event_seat),
            buildInfoItem("Lokasi", widget.details, Icons.location_on),
            buildInfoItem("Biaya", widget.cost, Icons.attach_money),
            buildInfoItem(
                "Jenis Kendaraan", widget.vehicleType, Icons.directions_car),
            buildInfoItem("Pemberi Tumpangan", widget.user, Icons.person),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
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
                            await FirebaseFirestore.instance
                                .collection('bookings')
                                .add({
                              'date': widget.date,
                              'time': widget.time,
                              'seatCount': widget.seatCount,
                              'details': widget.details,
                              'cost': widget.cost,
                              'vehicleType': widget.vehicleType,
                              'user': widget.user,
                              'status': statusPemesanan.toString(),
                            });

                            Navigator.of(context)
                                .pop(); // Tutup dialog konfirmasi
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Konfirmasi Pemesanan'),
                                  content: Text(statusPemesanan.toString()),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Tutup'),
                                    ),
                                  ],
                                );
                              },
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
