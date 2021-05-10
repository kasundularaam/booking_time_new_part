import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.password,
    this.email,
    this.nic,
    this.contact,
    this.district,
  });

  int id;
  String name;
  String password;
  String email;
  String nic;
  int contact;
  String district;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        password: json["password"],
        email: json["email"],
        nic: json["nic"],
        contact: json["contact"],
        district: json["district"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "password": password,
        "email": email,
        "nic": nic,
        "contact": contact,
        "district": district,
      };
}
