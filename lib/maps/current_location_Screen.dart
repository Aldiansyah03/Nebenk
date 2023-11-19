import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({super.key});

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(-1.2379, 116.8529), zoom: 14);

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lokasi Saat Ini"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();

          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14)));

          markers.clear();

          markers.add(Marker(
              markerId: const MarkerId("current-location"),
              position: LatLng(position.latitude, position.longitude)));

          setState(() {});
        },
        label: const Text("Posisi Saat Ini"),
        icon: const Icon(Icons.location_history),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Menampilkan pesan bahwa layanan lokasi dinonaktifkan
      return Future.error("Location services disabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Menampilkan pesan bahwa izin lokasi ditolak secara permanen
      return Future.error("Location permissions permanently denied");
    }

    if (permission == LocationPermission.denied) {
      // Jika izin ditolak, minta izin kembali
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Menampilkan pesan bahwa izin lokasi ditolak
        return Future.error("Location permissions denied");
      }
    }

    // Jika izin diberikan, dapatkan posisi saat ini
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
