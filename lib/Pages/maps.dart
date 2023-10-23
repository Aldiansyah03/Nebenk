import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlng/latlng.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TomTom Map Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String apiKey = 'tw9bp01ljmUiAykffKcxrcGZDnOpGrbk';

  @override
  Widget build(BuildContext context) {
    final tomtomHQ = LatLng(52.376372, 4.908066);

    return Scaffold(
      appBar: AppBar(
        title: Text('TomTom Map'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: tomtomHQ,
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                'https://api.tomtom.com/map/1/tile/basic/main/{z}/{x}/{y}.png?key=$apiKey',
            subdomains: ['a', 'b', 'c'],
          ),
        ],
      ),
    );
  }
}
