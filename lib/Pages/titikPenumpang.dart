// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nebengk/Pages/penumpang.dart';

class PCurrentLocationScreen extends StatefulWidget {
  const PCurrentLocationScreen({Key? key});

  @override
  State<PCurrentLocationScreen> createState() => _PCurrentLocationScreenState();
}

class _PCurrentLocationScreenState extends State<PCurrentLocationScreen> {
  late GoogleMapController googleMapController;
  late LatLng userSelectedLocation;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(-1.2379, 116.8529), zoom: 14);

  Set<Marker> markers = {};

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

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
          _fetchLocation();
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
            onPressed: () async {
              Position position = await _determinePosition();
              setState(() {
                userSelectedLocation = LatLng(
                  position.latitude,
                  position.longitude,
                );
                markers.add(
                  Marker(
                    markerId: const MarkerId("Posisi Saat Ini"),
                    position: userSelectedLocation,
                    infoWindow: const InfoWindow(
                      title: "Posisi Saat Ini",
                      snippet: "Lokasi Saat Ini",
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed,
                    ),
                  ),
                );
              });
            },
            label: const Text("Posisi Saat Ini"),
            icon: const Icon(Icons.location_history),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              if (userSelectedLocation != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Penumpang(userSelectedLocation: userSelectedLocation),
                  ),
                );
              } else {
                _showErrorDialog("Anda belum memilih lokasi saat ini.");
              }
            },
            label: const Text("Oke"),
            icon: const Icon(Icons.check),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchLocation() async {
    try {
      Position position = await _determinePosition();

      userSelectedLocation = LatLng(
        position.latitude,
        position.longitude,
      );
      markers.add(
        Marker(
          markerId: const MarkerId("Posisi Saat ini"),
          position: userSelectedLocation,
          infoWindow: const InfoWindow(
              title: "Posisi Saat ini", snippet: "lokasi saat ini"),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
        ),
      );

      if (googleMapController != null) {
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            (CameraPosition(target: userSelectedLocation, zoom: 15))));
      }
      setState(() {
        userSelectedLocation = LatLng(
          position.latitude,
          position.longitude,
        );
        markers.add(
          Marker(
            markerId: const MarkerId("Posisi Saat Ini"),
            position: userSelectedLocation,
            infoWindow: const InfoWindow(
              title: "Posisi Saat Ini",
              snippet: "Lokasi Saat Ini",
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
          ),
        );
      });

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

    return await Geolocator.getCurrentPosition();
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
