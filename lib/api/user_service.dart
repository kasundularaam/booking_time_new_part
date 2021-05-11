import 'dart:convert';
import 'dart:io';

import 'package:booking_time/models/user_model.dart';

import 'package:http/http.dart' as http;

class UserServices {
  List<User> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  Future<List<User>> getAllUsers() async {
    String url = "http://www.snp-solutions.xyz:3001/user";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return parseUsers(response.body);
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  Future<User> loginWithEmailAndPw(String email, String password) async {
    if (email.isNotEmpty && email != null) {
      if (password.isNotEmpty && password != null) {
        List<User> userList = await getAllUsers();
        if (userList != null) {
          User currentUser;
          userList.forEach((user) {
            if (user.email == email && user.password == password) {
              currentUser = user;
            }
          });
          return currentUser;
        } else {
          throw Exception("cant fetch data from API");
        }
      } else {
        throw Exception("password is null or empty");
      }
    } else {
      throw Exception("email is null or empty");
    }
  }

  Future<bool> createAcount(User user) async {
    print(user.contact);
    String url = "http://www.snp-solutions.xyz:3001/user";

    final http.Response response = await http.post(Uri.parse(url),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: userToJson(user));
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      throw Exception("${response.statusCode}");
    }
  }
}
