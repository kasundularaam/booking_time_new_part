import 'dart:convert';

Menue menueFromJson(String str) => Menue.fromJson(json.decode(str));

String menueToJson(Menue data) => json.encode(data.toJson());

class Menue {
  Menue({
    this.id,
    this.rid,
    this.name,
    this.price,
    this.image,
    this.description,
  });

  int id;
  int rid;
  String name;
  int price;
  String image;
  String description;

  factory Menue.fromJson(Map<String, dynamic> json) => Menue(
        id: json["Id"],
        rid: json["RID"],
        name: json["Name"],
        price: json["Price"],
        image: json["Image"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "RID": rid,
        "Name": name,
        "Price": price,
        "Image": image,
        "Description": description,
      };
}
