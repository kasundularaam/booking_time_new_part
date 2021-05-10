import 'package:flutter/cupertino.dart';

class Rest {
  final int id;
  // ignore: non_constant_identifier_names
  final String r_name;
  final String image;

  // ignore: non_constant_identifier_names
  Rest({@required this.id, @required this.r_name, @required this.image});

  factory Rest.fromJson(Map<String, dynamic> json) {
    return Rest(
      id: json["Id"],
      r_name: json["R_Name"],
      image: json["image"],
    );
  }
}
