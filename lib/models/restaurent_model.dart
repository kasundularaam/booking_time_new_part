import 'dart:convert';

Restaurent restaurentFromJson(String str) =>
    Restaurent.fromJson(json.decode(str));

String restaurentToJson(Restaurent data) => json.encode(data.toJson());

class Restaurent {
  Restaurent({
    this.id,
    this.rName,
    this.address,
    this.province,
    this.email,
    this.password,
    this.registeredNumber,
    this.district,
    this.approve,
    this.contact,
  });

  int id;
  String rName;
  String address;
  String province;
  String email;
  String password;
  String registeredNumber;
  String district;
  int approve;
  int contact;

  factory Restaurent.fromJson(Map<String, dynamic> json) => Restaurent(
        id: json["id"],
        rName: json["r_Name"],
        address: json["address"],
        province: json["province"],
        email: json["email"],
        password: json["password"],
        registeredNumber: json["registered_Number"],
        district: json["district"],
        approve: json["approve"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "r_Name": rName,
        "address": address,
        "province": province,
        "email": email,
        "password": password,
        "registered_Number": registeredNumber,
        "district": district,
        "approve": approve,
        "contact": contact,
      };
}
