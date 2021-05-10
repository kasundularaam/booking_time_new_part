import 'package:booking_time/api/user_service.dart';
import 'package:booking_time/components/custom_alert.dart';
import 'package:booking_time/components/custom_loading.dart';
import 'package:booking_time/models/user_model.dart';
import 'package:booking_time/screens/home_screen.dart';
import 'package:booking_time/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:booking_time/components/rounded_buttons.dart';
import 'package:booking_time/components/rounded_textfields.dart';

class SignupScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  UserServices _userServices = UserServices();
  String _name;
  String _email;
  String _nic;
  int _contact;
  String _district;
  String _password;
  String _confirmPassword;

  User createUser() {
    User newUser = User(
      name: _name,
      email: _email,
      nic: _nic,
      contact: _contact,
      district: _district,
      password: _password,
    );
    return newUser;
  }

  Future<void> createNewAccount() async {
    if (_confirmPassword == _password) {
      CustomLoading.showLoadingDialog(context: context, message: "Signing...");
      try {
        bool userAdded = await _userServices.createAcount(createUser());
        if (userAdded) {
          CustomLoading.closeLoading(context: context);
          Navigator.pushNamed(context, HomeScreen.id);
        } else {
          CustomLoading.closeLoading(context: context);
          CustomAlert.alertDialogBuilder(
              context: context,
              title: "Error",
              message: "somthing went wrong",
              action: "Ok");
          print("user is null");
          print("somthing went wrong!!!");
        }
      } catch (e) {
        CustomLoading.closeLoading(context: context);
        CustomAlert.alertDialogBuilder(
            context: context, title: "Error", message: "$e", action: "Ok");
      }
    } else {
      CustomAlert.alertDialogBuilder(
          context: context,
          title: "Error",
          message: "passwords don't match",
          action: "Ok");
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
                        "Sign up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Create an account, It's free",
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
                child: Column(
                  children: [
                    RoundedTextfields(
                        label: "Name", onChanged: (value) => _name = value),
                    RoundedTextfields(
                        label: "Email", onChanged: (value) => _email = value),
                    RoundedTextfields(
                        label: "NIC", onChanged: (value) => _nic = value),
                    RoundedTextfields(
                        label: "Contact",
                        onChanged: (value) => _contact = int.parse(value)),
                    RoundedTextfields(
                        label: "District",
                        onChanged: (value) => _district = value),
                    RoundedTextfields(
                        label: "Password",
                        obscureText: true,
                        onChanged: (value) => _password = value),
                    RoundedTextfields(
                        label: "Confirm Password",
                        obscureText: true,
                        onChanged: (value) => _confirmPassword = value),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: RoundedButton(
                        title: "Sign up",
                        buttonColor: Colors.purpleAccent,
                        textColor: Colors.white,
                        onPressed: () {
                          createNewAccount();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 55.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Text("Already have an account?"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginScreen.id);
                            },
                            child: Text(
                              "Login",
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
