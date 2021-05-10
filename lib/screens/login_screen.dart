import 'package:booking_time/api/user_service.dart';
import 'package:booking_time/components/custom_alert.dart';
import 'package:booking_time/components/custom_loading.dart';
import 'package:booking_time/constants.dart';
import 'package:booking_time/models/user_model.dart';
import 'package:booking_time/screens/home_screen.dart';
import 'package:booking_time/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:booking_time/components/rounded_buttons.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserServices _userServices = UserServices();

  String _email;
  String _password;

  Future<void> loginUser() async {
    CustomLoading.showLoadingDialog(context: context, message: "Loging...");
    try {
      User currentUser =
          await _userServices.loginWithEmailAndPw(_email, _password);
      if (currentUser != null) {
        print(currentUser.nic);
        CustomLoading.closeLoading(context: context);
        Navigator.pushNamed(context, HomeScreen.id);
      } else {
        CustomLoading.closeLoading(context: context);
        CustomAlert.alertDialogBuilder(
            context: context,
            title: "Error",
            message: "wrong email or password",
            action: "Ok");
        print("user is null");
        print("somthing went wrong!!!");
      }
    } catch (e) {
      CustomLoading.closeLoading(context: context);
      CustomAlert.alertDialogBuilder(
          context: context, title: "Error", message: "$e", action: "Ok");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
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
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Login to your account",
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
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => _email = value,
                      // onSaved: (input) => requestModel.email = input,
                      decoration:
                          kTextFieldDecoration.copyWith(labelText: "Email"),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) => _password = value,
                      // onSaved: (input) => requestModel.password = input,
                      decoration:
                          kTextFieldDecoration.copyWith(labelText: "Password"),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
                    RoundedButton(
                      title: "Login",
                      buttonColor: Colors.purpleAccent,
                      textColor: Colors.black,
                      onPressed: () {
                        loginUser();
                        // print(requestModel.toJson());
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 55.0,
                        vertical: 20.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Text("Don't have an account?"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SignupScreen.id);
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.purpleAccent,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
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
