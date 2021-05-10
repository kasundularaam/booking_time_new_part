import 'dart:convert';

import 'package:booking_time/models/restaurent_model.dart';

import 'package:http/http.dart' as http;

class RestaurentServices {
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
}
