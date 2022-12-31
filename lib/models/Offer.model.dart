// To parse this JSON data, do
//
//     final offerModel = offerModelFromJson(jsonString);

import 'dart:convert';

List<OfferModel> offerModelFromJson(String str) => List<OfferModel>.from(json.decode(str).map((x) => OfferModel.fromJson(x)));

String offerModelToJson(List<OfferModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OfferModel {
  OfferModel({
    required this.proId,
    required this.proName,
    required this.proCatId,
    required this.proImg,
    required this.proSpec,
    required this.proDesc,
    required this.proSell,
    required this.proOffer,
    required this.upcoming,
    required this.inOffer,
    required this.offerTillDate,
    required this.occupation,
    required this.newArrival,
    required this.proCreatedOn,
    required this.proUpdateOn,
    required this.proAvailable,
    required this.proCod,
    required this.proFlag,
  });

  String proId;
  String proName;
  String proCatId;
  String proImg;
  String proSpec;
  String proDesc;
  String proSell;
  String proOffer;
  String upcoming;
  String inOffer;
  String offerTillDate;
  String occupation;
  String newArrival;
  DateTime proCreatedOn;
  DateTime proUpdateOn;
  String proAvailable;
  String proCod;
  String proFlag;

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
    proId: json["pro_id"],
    proName: json["pro_name"],
    proCatId: json["pro_cat_id"],
    proImg: json["pro_img"],
    proSpec: json["pro_spec"],
    proDesc: json["pro_desc"],
    proSell: json["pro_sell"],
    proOffer: json["pro_offer"],
    upcoming: json["upcoming"],
    inOffer: json["in_offer"],
    offerTillDate: json["offer_till_date"],
    occupation: json["occupation"],
    newArrival: json["new_arrival"],
    proCreatedOn: DateTime.parse(json["pro_created_on"]),
    proUpdateOn: DateTime.parse(json["pro_update_on"]),
    proAvailable: json["pro_available"],
    proCod: json["pro_cod"],
    proFlag: json["pro_flag"],
  );

  Map<String, dynamic> toJson() => {
    "pro_id": proId,
    "pro_name": proName,
    "pro_cat_id": proCatId,
    "pro_img": proImg,
    "pro_spec": proSpec,
    "pro_desc": proDesc,
    "pro_sell": proSell,
    "pro_offer": proOffer,
    "upcoming": upcoming,
    "in_offer": inOffer,
    "offer_till_date": offerTillDate,
    "occupation": occupation,
    "new_arrival": newArrival,
    "pro_created_on": proCreatedOn.toIso8601String(),
    "pro_update_on": proUpdateOn.toIso8601String(),
    "pro_available": proAvailable,
    "pro_cod": proCod,
    "pro_flag": proFlag,
  };
}
