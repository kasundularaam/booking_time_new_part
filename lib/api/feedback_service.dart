import 'dart:convert';

import 'package:booking_time/models/feedback_model.dart';

import 'package:http/http.dart' as http;

class FeedbackServices {
  List<Feedback> parseFeedbacks(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Feedback>((json) => Feedback.fromJson(json)).toList();
  }

  Future<List<Feedback>> getAllFeedbacks() async {
    String url = "http://www.snp-solutions.xyz:3001/feedback";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return parseFeedbacks(response.body);
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  Future<int> getFeedbackCountForRest(int restId) async {
    List<Feedback> feedbackList = await getAllFeedbacks();
    List<Feedback> restFeedbackList = [];
    feedbackList.forEach((feedback) {
      if (feedback.rid == restId) {
        restFeedbackList.add(feedback);
      }
    });
    return restFeedbackList.length;
  }
}
