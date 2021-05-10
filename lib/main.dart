import 'package:booking_time/screens/booking_screen.dart';
import 'package:booking_time/screens/feedbacks_screen.dart';
import 'package:booking_time/screens/home_screen.dart';
import 'package:booking_time/screens/login_screen.dart';
import 'package:booking_time/screens/reservation_screen.dart';
import 'package:booking_time/screens/signup_screen.dart';
import 'package:booking_time/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BookingTime());
}

class BookingTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ReservationScreen.id: (context) => ReservationScreen(),
        FeedbacksScreen.id: (context) => FeedbacksScreen(),
        BookingScreen.id: (context) => BookingScreen(),
      },
    );
  }
}
