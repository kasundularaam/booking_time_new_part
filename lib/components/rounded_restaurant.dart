import 'package:booking_time/api/feedback_service.dart';
import 'package:booking_time/screens/booking_screen.dart';
import 'package:flutter/material.dart';

class RoundedRest extends StatefulWidget {
  const RoundedRest({Key key, this.image, this.rName, this.restId})
      : super(key: key);

  final int restId;
  final String image;
  final String rName;

  @override
  _RoundedRestState createState() => _RoundedRestState();
}

class _RoundedRestState extends State<RoundedRest> {
  FeedbackServices _feedbackServices = FeedbackServices();

  Future<int> getFeedbackCount() async {
    int feedbackCount =
        await _feedbackServices.getFeedbackCountForRest(widget.restId);
    return feedbackCount;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, BookingScreen.id,
              arguments: {"rId": widget.restId});
        },
        child: Card(
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Text(
                            widget.rName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: FutureBuilder(
                            future: getFeedbackCount(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                  "error..",
                                  style: TextStyle(color: Colors.grey),
                                );
                              }
                              if (snapshot.hasData) {
                                return Text(
                                  "${snapshot.data} feedbacks",
                                  style: TextStyle(color: Colors.grey),
                                );
                              }
                              return Text(
                                "Loading...",
                                style: TextStyle(color: Colors.grey),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: CircleAvatar(
                        child: Text(
                          "4.5",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
