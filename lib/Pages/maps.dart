import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

// ...
class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  LatLng? _initialLocation;
  LatLng? _destinationLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: _initialLocation ?? LatLng(-1.267530, 116.828873),
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
        onTap: (LatLng latLng) {
          _setLocations(latLng);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _searchRoute();
        },
        label: const Text('Set Route'),
        icon: const Icon(Icons.directions),
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

  void _setLocations(LatLng latLng) {
    setState(() {
      if (_initialLocation == null) {
        _initialLocation = latLng;
      } else if (_destinationLocation == null) {
        _destinationLocation = latLng;
        _addMarker(_destinationLocation!);
      }
    });
  }

  Future<void> _searchRoute() async {
    if (_initialLocation != null && _destinationLocation != null) {
      final List<LatLng> routeCoordinates =
          await _getRouteCoordinates(_initialLocation!, _destinationLocation!);
      // Handle routeCoordinates to draw the route on the map or perform navigation
      // For simplicity, the route coordinates are returned here.
      print('Route Coordinates: $routeCoordinates');
    } else {
      // Handle if either initial or destination location is missing
      print('Please set both initial and destination locations.');
    }
  }

  Future<List<LatLng>> _getRouteCoordinates(
      LatLng initialLocation, LatLng destinationLocation) async {
    // Here, you can implement logic to get the route coordinates
    // This might involve using a routing API like Google Directions API
    // or any other routing service to obtain the coordinates between the two locations.
    // For simplicity, returning a list of LatLng as a sample.
    return [initialLocation, destinationLocation];
  }
}
