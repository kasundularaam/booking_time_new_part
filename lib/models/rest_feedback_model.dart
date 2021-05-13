import 'dart:convert';

RestFeedback restFeedbackFromJson(String str) =>
    RestFeedback.fromJson(json.decode(str));

String restFeedbackToJson(RestFeedback data) => json.encode(data.toJson());

class RestFeedback {
  RestFeedback({
    this.id,
    this.cid,
    this.rid,
    this.description,
  });

  int id;
  int cid;
  int rid;
  String description;

  factory RestFeedback.fromJson(Map<String, dynamic> json) => RestFeedback(
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
