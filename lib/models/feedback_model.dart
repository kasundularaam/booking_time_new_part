import 'dart:convert';

Feedback feedbackFromJson(String str) => Feedback.fromJson(json.decode(str));

String feedbackToJson(Feedback data) => json.encode(data.toJson());

class Feedback {
  Feedback({
    this.id,
    this.cid,
    this.rid,
    this.description,
  });

  int id;
  int cid;
  int rid;
  String description;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        id: json["Id"],
        cid: json["CID"],
        rid: json["RID"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cid": cid,
        "rid": rid,
        "description": description,
      };
}
