import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key =
      'AIzaSyDUxErMvsL-JYPxMw08E8PVL1SCno9pixI'; // Pastikan untuk mengganti 'API_KEY' dengan kunci API sebenarnya Anda

  Future<String> getPlaceId(String input) async {
    try {
      final String url =
          'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var json = convert.jsonDecode(response.body);
        var candidates = json['candidates'] as List<dynamic>;

        if (candidates.isNotEmpty) {
          var placeId = candidates[0]['place_id'] as String;
          return placeId;
        } else {
          throw Exception('No place found for the given input');
        }
      } else {
        throw Exception('Failed to get place ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in getPlaceId: $e');
    }
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    try {
      final placeId = await getPlaceId(input);

      final String url =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var json = convert.jsonDecode(response.body);
        var results = json['result'] as Map<String, dynamic>;

        return results;
      } else {
        throw Exception('Failed to get place details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in getPlace: $e');
    }
  }

  Future<Map<String, dynamic>> getDirections(
      String origin, String destination) async {
    try {
      final String url =
          'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$key';

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var json = convert.jsonDecode(response.body);
        var routes = json['routes'] as List<dynamic>;

        if (routes.isNotEmpty) {
          var firstRoute = routes[0] as Map<String, dynamic>;
          var bounds = firstRoute['bounds'] as Map<String, dynamic>;
          var legs = firstRoute['legs'] as List<dynamic>;
          var overviewPolyline =
              firstRoute['overview_polyline'] as Map<String, dynamic>;

          var results = {
            'bounds_ne': bounds['northeast'],
            'bounds_sw': bounds['southwest'],
            'start_location': legs[0]['start_location'],
            'end_location': legs[0]['end_location'],
            'polyline': overviewPolyline['points'],
            'polyline_decoded':
                PolylinePoints().decodePolyline(overviewPolyline['points']),
          };

          return results;
        } else {
          throw Exception('No routes found for the given locations');
        }
      } else {
        throw Exception('Failed to get directions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in getDirections: $e');
    }
  }
}
