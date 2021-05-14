import 'dart:convert';

import 'package:booking_time/models/restaurent_model.dart';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class RestaurentServices {
  Location _location = Location();
  LocationData _currentPosition;
  List<Restaurent> parseRestaurent(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Restaurent>((json) => Restaurent.fromJson(json)).toList();
  }

  Future<List<Restaurent>> getAllRestaurents() async {
    String url = "http://www.snp-solutions.xyz:3001/restaurent";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return parseRestaurent(response.body);
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await _location.getLocation();
  }

  Future<List<Restaurent>> getRestaurentsByLoc() async {
    await getLoc();
    if (_currentPosition != null) {
      double lat = _currentPosition.latitude;
      double long = _currentPosition.longitude;
      String url =
          "http://www.snp-solutions.xyz:3001/restaurent?lat=$lat&&long=$long";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return parseRestaurent(response.body);
      } else {
        throw Exception('${response.statusCode}');
      }
    } else {
      throw Exception('error occurred while getting current location');
    }
  }

  Future<List<Restaurent>> searchRestByName(String rName) async {
    List<Restaurent> allRestList = await getAllRestaurents();
    List<Restaurent> filteredList = [];

    allRestList.forEach((rest) {
      String restName = rest.rName.toString().trim().toLowerCase();
      if (restName.contains(rName)) {
        filteredList.clear();
        filteredList.add(rest);
      }
    });
    return filteredList;
  }

  Future<Restaurent> getRestaurentById(int rId) async {
    String url = "http://www.snp-solutions.xyz:3001/restaurent/$rId";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<Restaurent> restList = parseRestaurent(response.body);
      return restList[0];
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
