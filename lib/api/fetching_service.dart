import 'dart:convert';
import 'package:booking_time/api/api_service.dart';
import 'package:booking_time/models/restaurant_for_listing.dart';
import 'package:http/http.dart' as http;

class FetchService {
  Future<Rest> fetchRest() async {
    final response = await http.get(
      Uri.parse(APIService.API + "/restaurent"),
    );

    if (response.statusCode == 200) {
      return Rest.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }
}
