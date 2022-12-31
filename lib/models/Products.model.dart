// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

List<ProductsModel> productsModelFromJson(String str) => List<ProductsModel>.from(json.decode(str).map((x) => ProductsModel.fromJson(x)));

String productsModelToJson(List<ProductsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsModel {
  ProductsModel({
    required this.proId,
    required this.proName,
    required this.proCatId,
    required this.proImg,
    required this.proImg_p1,
    required this.proImg_p2,
    required this.proImg_p3,
    required this.proImg_p4,
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
  String proImg_p1;
  String proImg_p2;
  String proImg_p3;
  String proImg_p4;
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

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    proId: json["pro_id"],
    proName: json["pro_name"],
    proCatId: json["pro_cat_id"],
    proImg: json["pro_img"],
    proImg_p1: json["pro_img_p1"],
    proImg_p2: json["pro_img_p2"],
    proImg_p3: json["pro_img_p3"],
    proImg_p4: json["pro_img_p4"],
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
    "pro_img_p1": proImg_p1,
    "pro_img_p2": proImg_p2,
    "pro_img_p3": proImg_p3,
    "pro_img_p4": proImg_p4,
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
