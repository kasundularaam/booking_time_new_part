import 'package:booking_time/api/feedback_service.dart';
import 'package:booking_time/components/custom_alert.dart';
import 'package:booking_time/components/custom_loading.dart';
import 'package:booking_time/components/rounded_buttons.dart';
import 'package:booking_time/components/rounded_feedback.dart';
import 'package:booking_time/constants.dart';
import 'package:booking_time/models/rest_feedback_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbacksScreen extends StatefulWidget {
  static const String id = "feedbacks_screen";
  const FeedbacksScreen({Key key}) : super(key: key);

  @override
  _FeedbacksScreenState createState() => _FeedbacksScreenState();
}

class _FeedbacksScreenState extends State<FeedbacksScreen> {
  FeedbackServices _services = FeedbackServices();
  int _rId;
  int _cId;
  String _description;

  RestFeedback getFeedbackData() {
    RestFeedback feedback;
    if (_rId != null && _cId != null && _description != null) {
      feedback = RestFeedback(
        rid: _rId,
        cid: _cId,
        description: _description,
      );
      return feedback;
    } else {
      throw Exception("Some inputs are null");
    }
  }

  Future<void> addFeedback() async {
    CustomLoading.showLoadingDialog(
        context: context, message: "Adding your feedback...");
    try {
      bool feedbackAdded = await _services.addFeedback(getFeedbackData());
      if (feedbackAdded) {
        CustomLoading.closeLoading(context: context);
        CustomAlert.alertDialogBuilder(
            context: context,
            title: "Success",
            message: "Feedback added successfully",
            action: "Ok");
        setState(() {
          _services = FeedbackServices();
        });
      } else {
        CustomLoading.closeLoading(context: context);
        CustomAlert.alertDialogBuilder(
            context: context,
            title: "Failed",
            message: "Failed to add feedback",
            action: "Ok");
      }
    } catch (e) {
      CustomLoading.closeLoading(context: context);
      CustomAlert.alertDialogBuilder(
          context: context, title: "Error", message: "$e", action: "Ok");
    }
  }

  Future<void> getArgsAndPrefs() async {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) _rId = arguments['rId'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cId = prefs.getInt("uId");
  }

  @override
  Widget build(BuildContext context) {
    getArgsAndPrefs();
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
                      onChanged: (value) => _description = value,
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
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: RoundedButton(
                    title: "Send",
                    buttonColor: Colors.purple,
                    textColor: Colors.white,
                    onPressed: () {
                      addFeedback();
                      // print(requestModel.toJson());
                    },
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                FutureBuilder(
                  future: _services.getFeedbacksByRid(_rId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "${snapshot.error}",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      List<RestFeedback> fbList = snapshot.data;
                      if (fbList.isNotEmpty) {
                        return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: fbList.length,
                            itemBuilder: (context, index) {
                              RestFeedback feedback = fbList[index];
                              return RoundedFeedback(feedback: feedback);
                            });
                      } else {
                        Center(
                          child: Text(
                            "no feedbacks",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
