import 'package:flutter/material.dart';

class Passenger {
  final String name;
  final String address;

  Passenger({
    required this.name,
    required this.address,
  });
}

class DetailPenumpang extends StatelessWidget {
  // Daftar contoh data akun penumpang
  final List<Passenger> passengers = [
    Passenger(name: "Aldi", address: "Sepinggan"),
    Passenger(name: "Alpian", address: "Kilo 10"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: Color(0xFF3668B2),
        title: Text("Detail Penumpang"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Penumpang yang Memesan Kursi", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: passengers.length,
              itemBuilder: (context, index) {
                return buildPassengerItem(passengers[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPassengerItem(Passenger passenger) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          // Gambar akun
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/user_image.jpg'), // Ganti dengan path gambar akun
              ),
            ),
          ),
          SizedBox(width: 10.0),
          // Nama akun dan alamat
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(passenger.name, style: TextStyle(fontSize: 16.0)),
              Text(passenger.address, style: TextStyle(fontSize: 14.0, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

