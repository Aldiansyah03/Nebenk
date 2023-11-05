import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Location_Service {
  final String key = 'AIzaSyDUxErMvsL-JYPxMw08E8PVL1SCno9pixI';

  Future<String> getPlaceid(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input= $input&inputtype=textquery&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final PlaceId = await getPlaceid(input);

    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$PlaceId&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    print(results);
    return results;
  }
}
