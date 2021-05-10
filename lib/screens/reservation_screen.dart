import 'package:booking_time/components/rounded_buttons.dart';
import 'package:booking_time/components/rounded_date_and_time_field.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key key}) : super(key: key);

  static const String id = 'reservation_screen';

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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 70.0),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Reservation",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Reserve a table",
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 55.0),
                child: Column(
                  children: [
                    RoundedDateField(),
                    SizedBox(
                      height: 40.0,
                    ),
                    RoundedTimeField(),
                    SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration:
                          kTextFieldDecoration.copyWith(labelText: "Table No."),
                    ),
                    SizedBox(
                      height: 150.0,
                    ),
                    RoundedButton(
                      title: "Reserve",
                      buttonColor: Colors.purple,
                      textColor: Colors.white,
                      onPressed: () {
                        // print(requestModel.toJson());
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
