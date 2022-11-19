import '../models/result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlacesApi {
  Future<Result> getPlaces(String parameter, String lon, String lat) async {
    print(lon + ' ' + lat);
    print(parameter);
    final response = await http.get(Uri.parse(
        // 'http://api.opentripmap.com/0.1/en/places/radius?lon=2.440597&lat= -76.615253&radius=100000000&kinds=$parameter&format=json&keyapi=5ae2e3f221c38a28845f05b65ebe21c760ce24d27153f14a1bb7bcf3'));
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lon,$lat&radius=500&types=$parameter&key=AIzaSyANQwggohVUD-yK20SHj-RqT6BPL5ZglFg'));

    if (response.statusCode == 200) {
      print('Solicitud realizada');
      print(response.body);
      return Result.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load places');
    }
  }
}
