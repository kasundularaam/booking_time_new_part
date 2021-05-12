import 'dart:io';

import 'package:booking_time/models/reservation_model.dart';

import 'package:http/http.dart' as http;

class ReservationService {
  Future<bool> addReservation(Reservation reservation) async {
    String url = "http://www.snp-solutions.xyz:3001/reservation";

    final http.Response response = await http.post(Uri.parse(url),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: reservationToJson(reservation));
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      throw Exception("${response.statusCode}");
    }
  }
}
