import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-1.267530, 116.828873),
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
        onTap: _addMarker,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Action when the floating action button is pressed
          // You can add your custom logic here for navigation or any other action.
        },
        label: const Text('Navigate'),
        icon: const Icon(Icons.navigation),
      ),
    );
  }

  void _addMarker(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId('Destination'),
        position: latLng,
      ));
    });
  }
}
