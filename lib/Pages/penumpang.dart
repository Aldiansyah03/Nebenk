import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:nebengk/Pages/PemesananKursiPage.dart';

class Penumpang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3668B2),
        title: const Text("NeBengK"),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('trips').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final trips = snapshot.data!.docs;
            final currentTime = DateTime.now();

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

                        final dateString = data['tanggalbatas'] as String?;
                        if (dateString != null) {
                          final parsedDate = DateTime.tryParse(dateString);
                          if (parsedDate != null) {
                            if (parsedDate.isAfter(currentTime)) {
                              final formattedDate =
                                  DateFormat('dd-MM-yyyy HH:mm')
                                      .format(parsedDate);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PemesananKursiPage(
                                            tanggalbatas: data['tanggalbatas'],
                                            date: data['date'],
                                            time: data['time'],
                                            deadline: data['deadline'],
                                            seatCount:
                                                data['seatCount'].toString(),
                                            details: data['details'],
                                            cost: data['cost'],
                                            vehicleType: data['vehicleType'],
                                            user: data['user'],
                                          )));
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
                                      "Tanggal dan Waktu : $formattedDate\nJumlah Kursi: ${data['seatCount']}\nPemberi Tumpangan: ${data['user']}",
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }
                        }
                        return const SizedBox();
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
