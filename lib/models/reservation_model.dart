import 'dart:convert';

Reservation reservationFromJson(String str) =>
    Reservation.fromJson(json.decode(str));

String reservationToJson(Reservation data) => json.encode(data.toJson());

class Reservation {
  Reservation({
    this.cid,
    this.rid,
    this.bookingTime,
    this.bookingDate,
    this.noOfParticipant,
  });

  int cid;
  int rid;
  String bookingTime;
  String bookingDate;
  int noOfParticipant;

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        cid: json["cid"],
        rid: json["rid"],
        bookingTime: json["bookingTime"],
        bookingDate: json["bookingDate"],
        noOfParticipant: json["noOfParticipant"],
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "rid": rid,
        "bookingTime": bookingTime,
        "bookingDate": bookingDate,
        "noOfParticipant": noOfParticipant,
      };
}
