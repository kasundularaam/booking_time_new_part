import 'dart:convert';

import 'package:booking_time/models/menue_mdel.dart';
import 'package:http/http.dart' as http;

class MenueService {
  List<Menue> parseMenues(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Menue>((json) => Menue.fromJson(json)).toList();
  }

  Future<List<Menue>> getAllMenues() async {
    String url = "http://www.snp-solutions.xyz:3001/menue/";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return parseMenues(response.body);
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  Future<List<Menue>> getMenuesByRid(int rId) async {
    String url = "http://www.snp-solutions.xyz:3001/menue/$rId";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return parseMenues(response.body);
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
