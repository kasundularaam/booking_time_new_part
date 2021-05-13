import 'dart:convert';
import 'dart:io';

import 'package:booking_time/models/rest_feedback_model.dart';

import 'package:http/http.dart' as http;

class FeedbackServices {
  Future<bool> addFeedback(RestFeedback feedback) async {
    String url = "http://www.snp-solutions.xyz:3001/feedback";

    final http.Response response = await http.post(Uri.parse(url),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: restFeedbackToJson(feedback));
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      throw Exception("${response.statusCode}");
    }
  }

  List<RestFeedback> parseFeedbacks(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<RestFeedback>((json) => RestFeedback.fromJson(json))
        .toList();
  }

  Future<List<RestFeedback>> getAllFeedbacks() async {
    String url = "http://www.snp-solutions.xyz:3001/feedback";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return parseFeedbacks(response.body);
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  Future<List<RestFeedback>> getFeedbacksByRid(int restId) async {
    String url = "http://www.snp-solutions.xyz:3001/feedback/$restId";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return List.from(parseFeedbacks(response.body).reversed);
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  Future<int> getFeedbackCountForRest(int restId) async {
    List<RestFeedback> restFeedbackList = await getFeedbacksByRid(restId);
    return restFeedbackList.length;
  }
}
