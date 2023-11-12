import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Trip {
  String user;
  String vehicleType;
  int seatCount;
  String cost;
  String details;
  String deadline;
  String date;
  String time;

  Trip({
    required this.user,
    required this.vehicleType,
    required this.seatCount,
    required this.cost,
    required this.details,
    required this.deadline,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'vehicleType': vehicleType,
      'seatCount': seatCount,
      'cost': cost,
      'details': details,
      'deadline': deadline,
      'date': date,
      'time': time,
    };
  }
}

class PemesananKursiPage extends StatelessWidget {
  final String vehicleType;
  final String seatCount;
  final String cost;
  final String details;
  final String deadline;
  final String date;
  final String time;
  final String bookedSeats;
  final String user;

  PemesananKursiPage(
      {required this.vehicleType,
      required this.seatCount,
      required this.cost,
      required this.details,
      required this.deadline,
      required this.date,
      required this.time,
      required this.bookedSeats,
      required this.user});

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pemesanan Kursi'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoCard('Nama Pengemudi', user),
            _buildInfoCard('Tanggal', date),
            _buildInfoCard('Jam', time),
            _buildInfoCard('Jumlah Kursi', seatCount),
            _buildInfoCard('Lokasi', details),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (currentUser != null) {
                    final trip = Trip(
                      user: currentUser.displayName ?? 'User',
                      vehicleType: vehicleType,
                      seatCount: int.parse(seatCount),
                      cost: cost,
                      details: details,
                      deadline: deadline,
                      date: date,
                      time: time,
                    );

                    await FirebaseFirestore.instance
                        .collection('seat_bookings')
                        .add(trip.toMap());

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Pemesanan Kursi'),
                          content: Text(
                            'Pemesanan kursi telah dilakukan. Tunggu konfirmasi dari pemberi tumpangan.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );

                    // Perform additional actions or navigate to another screen here
                  } else {
                    print('User not authenticated. Please log in.');
                  }
                } catch (e) {
                  print('Error pemesanan kursi: $e');
                }
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
