import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nebengk/Pages/PemesananKursiPage.dart';
import 'package:nebengk/konfirmasi/konfirmasipenumpang.dart';

class Penumpang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3668B2),
        title: const Text("NeBengK"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => KonfirmasiPenumpangPage(),
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('trips').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator(); // Tampilkan loading jika data belum tersedia
            }

            final trips = snapshot.data!.docs;

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: 250,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Telusuri ...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: trips.length,
                      itemBuilder: (context, index) {
                        final trip = trips[index];
                        final data = trip.data() as Map<String, dynamic>;

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PemesananKursiPage(
                                  date: data['date'],
                                  time: data['time'],
                                  deadline: data['deadline'],
                                  seatCount: data['seatCount'].toString(),
                                  details: data['details'],
                                  cost: data['cost'],
                                  vehicleType: data['vehicleType'],
                                  user: data['user'],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            child: ListTile(
                              leading: const Icon(
                                Icons.directions_car,
                                size: 50,
                                color: Colors.blue,
                              ),
                              title: Text("Lokasi: ${data['details']}"),
                              subtitle: Text(
                                "Tanggal: ${data['date']}\nJam: ${data['time']}\nJumlah Kursi: ${data['seatCount']}\nPemberi Tumpangan: ${data['user']}",
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
