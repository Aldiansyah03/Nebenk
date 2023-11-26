import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nebengk/Pages/HomePage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final LatLng pickupLocation; // Lokasi penjemputan
  final LatLng dropoffLocation; // Lokasi tujuan

  const MapScreen({
    Key? key,
    required this.pickupLocation,
    required this.dropoffLocation,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3668B2),
        title: const Text('Lokasi Pemberi Tumpangan'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: widget.pickupLocation,
          zoom: 14.0,
        ),
        markers: _createMarkers(),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: const MarkerId('pickup'),
        position: widget.pickupLocation,
        infoWindow: const InfoWindow(title: 'Penjemputan'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
      Marker(
        markerId: const MarkerId('dropoff'),
        position: widget.dropoffLocation,
        infoWindow: const InfoWindow(title: 'Tujuan'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };
  }
}

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
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3668B2),
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
            buildInfoItem(
                "Jenis Kendaraan", widget.vehicleType, Icons.directions_car),
            buildInfoItem("Pemberi Tumpangan", widget.user, Icons.person),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(
                      pickupLocation: const LatLng(-6.1753924, 106.8271528),
                      dropoffLocation: const LatLng(-5.1753924, 106.8271528),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.white,
                minimumSize: const Size(100, 40),
              ),
              child: const Text("Tampilkan Lokasi Pemberi Tumpangan",
                  style: TextStyle(color: Colors.black)),
            ),
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
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF3668B2),
                onPrimary: Colors.white,
                minimumSize: const Size(100, 40),
              ),
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
        leading: Icon(icon, size: 30, color: const Color(0xFF3668B2)),
        title: Text("$label: $value"),
      ),
    );
  }
}
