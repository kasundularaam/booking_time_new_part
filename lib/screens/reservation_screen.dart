import 'package:booking_time/api/reservation_services.dart';
import 'package:booking_time/components/custom_alert.dart';
import 'package:booking_time/components/custom_loading.dart';
import 'package:booking_time/components/rounded_buttons.dart';
import 'package:booking_time/components/rounded_date_and_time_field.dart';
import 'package:booking_time/models/reservation_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class ReservationScreen extends StatefulWidget {
  // const ReservationScreen({Key key}) : super(key: key);
  static const String id = 'reservation_screen';

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  ReservationService _reservationService = ReservationService();

  int _rId;
  int _cId;
  String _bookingTime;
  String _bookingDate;
  int _noOfParticipant;

  Reservation getResData() {
    print("RID is: $_rId");
    print("CID is: $_cId");
    print(_bookingDate);
    print(_bookingTime);
    Reservation reservation;
    if (_rId != null &&
        _cId != null &&
        _bookingDate != null &&
        _bookingTime != null &&
        _noOfParticipant != null) {
      reservation = Reservation(
          rid: _rId,
          cid: _cId,
          bookingDate: _bookingDate,
          bookingTime: _bookingTime,
          noOfParticipant: _noOfParticipant);
      return reservation;
    } else {
      throw Exception("some values are empty");
    }
  }

  Future<void> addReservation() async {
    CustomLoading.showLoadingDialog(
        context: context, message: "Sending your request...");
    try {
      bool resAdded = await _reservationService.addReservation(getResData());
      if (resAdded) {
        CustomLoading.closeLoading(context: context);
        CustomAlert.alertDialogBuilder(
            context: context,
            title: "Success",
            message: "Reservation added successfully",
            action: "Ok");
      } else {
        CustomLoading.closeLoading(context: context);
        CustomAlert.alertDialogBuilder(
            context: context,
            title: "Failed",
            message: "Failed to add reservation",
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
                    RoundedDateField(
                      onChanged: (date) {
                        if (date != null) {
                          _bookingDate = DateFormat('y/M/d').format(date);
                          print(_bookingDate);
                        }
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    RoundedTimeField(
                      onChanged: (time) {
                        _bookingTime = DateFormat('HH:mm').format(time);
                        print(_bookingTime);
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _noOfParticipant = int.parse(value),
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: "Participants"),
                    ),
                    SizedBox(
                      height: 150.0,
                    ),
                    RoundedButton(
                      title: "Reserve",
                      buttonColor: Colors.purple,
                      textColor: Colors.white,
                      onPressed: () {
                        addReservation();
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
