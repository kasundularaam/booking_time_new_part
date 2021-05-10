import 'package:booking_time/components/rounded_buttons.dart';
import 'package:booking_time/constants.dart';
import 'package:flutter/material.dart';

class FeedbacksScreen extends StatelessWidget {
  static const String id = "feedbacks_screen";
  const FeedbacksScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 70.0,
            ),
            child: Column(
              children: [
                Container(
                  child: Text(
                    "Feedbacks",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Send your feedback",
                    style: TextStyle(fontSize: 15.0, color: Colors.grey[700]),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    child: TextFormField(
                      decoration: kTextFieldDecoration,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: RoundedButton(
                    title: "Send",
                    buttonColor: Colors.purple,
                    textColor: Colors.white,
                    onPressed: () {
                      // print(requestModel.toJson());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
