import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_google_maps_webservices/directions.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nebengk/Pages/PemesananKursiPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Penumpang extends StatefulWidget {
  final LatLng userSelectedLocation;

  const Penumpang({Key? key, required this.userSelectedLocation})
      : super(key: key);

  @override
  _PenumpangState createState() => _PenumpangState();
}

class _PenumpangState extends State<Penumpang> {
  double distanceInMeters = 0;
  double biaya = 0;

  @override
  void initState() {
    super.initState();
    _calculateDistance();
  }

  Future<void> _calculateDistance() async {
    const String apiKey = 'AIzaSyDUxErMvsL-JYPxMw08E8PVL1SCno9pixI';
    final String baseUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${widget.userSelectedLocation.latitude},${widget.userSelectedLocation.longitude}&destination=-1.1498851387881808,116.8622265112238&key=$apiKey';

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final List<dynamic> routes = data['routes'];
        final Map<String, dynamic> route = routes[0];
        final Map<String, dynamic> legs = route['legs'][0];
        final Map<String, dynamic> distance = legs['distance'];

        setState(() {
          distanceInMeters = distance['value'] / 1000; // Convert to kilometers
          biaya = distanceInMeters * 2000; // Calculate cost per meter
          if (distanceInMeters < 3) {
            biaya = 0;
          }
          biaya = biaya.ceilToDouble() / 1000.ceilToDouble();
        });
      } else {
        print('Error calculating distance: ${data['status']}');
      }
    } else {
      print('Error fetching data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // const LatLng comparisonLocation =
    //     LatLng(-1.1498851387881808, 116.8622265112238);

    // double distanceInMeters = Geolocator.distanceBetween(
    //   userSelectedLocation.latitude,
    //   userSelectedLocation.longitude,
    //   comparisonLocation.latitude,
    //   comparisonLocation.longitude,
    // );

    // double costpermeter = 2;
    // double biaya = distanceInMeters * costpermeter;

    // if (distanceInMeters < 3000) {
    //   biaya = 0;
    // }

    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3668B2),
        title: const Text("Pilih Tumpangan"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Jarak : ${distanceInMeters.toStringAsFixed(2)} km \n Biaya: Rp. ${biaya.toStringAsFixed(0)}.000 ,-",
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('trips').snapshots(),
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

                              final dateString =
                                  data['tanggalbatas'] as String?;
                              if (dateString != null) {
                                final parsedDate =
                                    DateTime.tryParse(dateString);
                                if (parsedDate != null) {
                                  if (parsedDate.isAfter(currentTime)) {
                                    final formattedDate =
                                        DateFormat('dd-MM-yyyy HH:mm')
                                            .format(parsedDate);
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              PemesananKursiPage(
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
                                          ),
                                        ));
                                      },
                                      child: Card(
                                        elevation: 2,
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.directions_car,
                                            size: 50,
                                            color: Colors.blue,
                                          ),
                                          title: Text(
                                              "Lokasi: ${data['details']}"),
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
          ],
        ),
      ),
    );
  }
}
