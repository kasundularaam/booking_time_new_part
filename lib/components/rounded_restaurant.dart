import 'package:booking_time/api/feedback_service.dart';
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
  int _feedbackCount = 0;

  @override
  void initState() async {
    super.initState();
    _feedbackCount =
        await _feedbackServices.getFeedbackCountForRest(widget.restId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
                        child: Text(
                          "$_feedbackCount reviews = S.ofkf",
                          style: TextStyle(color: Colors.grey),
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
    );
  }
}
