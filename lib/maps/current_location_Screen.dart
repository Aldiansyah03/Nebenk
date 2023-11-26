import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key});

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(-1.1499495, 116.8596087), zoom: 13);

  Set<Marker> markers = {};

  void _onLocationSelected(LatLng selectedLocation) {
    Navigator.pop(context, selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3668B2),
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
          _onLocationSelected(LatLng(position.latitude, position.longitude));
        },
        label: const Text("Posisi Saat Ini"),
        icon: const Icon(Icons.location_history),
        backgroundColor: const Color(0xFF3668B2),
      ),
    );
  }

  Future<void> _fetchLocation() async {
    try {
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
    } on LocationServiceDisabledException {
      _showErrorDialog("Layanan Lokasi Dinonaktifkan");
    } on LocationPermissionPermanentDeniedException {
      _showErrorDialog("Izin Lokasi Ditolak Secara Permanen");
    } on LocationPermissionDeniedException {
      _showErrorDialog("Izin Lokasi Ditolak");
    } catch (e) {
      _showErrorDialog("Terjadi Kesalahan: $e");
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceDisabledException();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionPermanentDeniedException();
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionDeniedException();
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class LocationServiceDisabledException implements Exception {}

class LocationPermissionDeniedException implements Exception {}

class LocationPermissionPermanentDeniedException implements Exception {}
