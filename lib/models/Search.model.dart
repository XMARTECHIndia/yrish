// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
  SearchModel({
    required this.proId,
    required this.proName,
    required this.proCatId,
    required this.proImg,
    required this.proImgP1,
    required this.proImgP2,
    required this.proImgP3,
    required this.proImgP4,
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
  String proImgP1;
  String proImgP2;
  String proImgP3;
  String proImgP4;
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

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    proId: json["pro_id"],
    proName: json["pro_name"],
    proCatId: json["pro_cat_id"],
    proImg: json["pro_img"],
    proImgP1: json["pro_img_p1"],
    proImgP2: json["pro_img_p2"],
    proImgP3: json["pro_img_p3"],
    proImgP4: json["pro_img_p4"],
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
    "pro_img_p1": proImgP1,
    "pro_img_p2": proImgP2,
    "pro_img_p3": proImgP3,
    "pro_img_p4": proImgP4,
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
