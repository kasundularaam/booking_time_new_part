import 'package:booking_time/api/feedback_service.dart';
import 'package:booking_time/api/user_service.dart';
import 'package:booking_time/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:booking_time/models/rest_feedback_model.dart';

class RoundedFeedback extends StatefulWidget {
  final RestFeedback feedback;
  const RoundedFeedback({
    Key key,
    @required this.feedback,
  }) : super(key: key);

  @override
  _RoundedFeedbackState createState() => _RoundedFeedbackState();
}

class _RoundedFeedbackState extends State<RoundedFeedback> {
  UserServices userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(1, 1),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: userServices.getUserByUid(widget.feedback.cid),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                      snapshot.error.toString(),
                      style: TextStyle(color: Colors.grey),
                    );
                  }
                  print("${snapshot.data}");
                  if (snapshot.hasData) {
                    User user = snapshot.data;
                    print("snapshot has data");
                    return Text(
                      "${user.name}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return Text(
                    "Loading...",
                    style: TextStyle(color: Colors.grey),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${widget.feedback.description}",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
