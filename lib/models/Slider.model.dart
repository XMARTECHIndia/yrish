// To parse this JSON data, do
//
//     final slidersModel = slidersModelFromJson(jsonString);

import 'dart:convert';

List<SlidersModel> slidersModelFromJson(String str) => List<SlidersModel>.from(json.decode(str).map((x) => SlidersModel.fromJson(x)));

String slidersModelToJson(List<SlidersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SlidersModel {
  SlidersModel({
    required this.sliderId,
    required this.sliderOrder,
    required this.sliderName,
    required this.sliderImg,
    required this.isEnable,
    required this.createdAt,
  });

  String sliderId;
  String sliderOrder;
  String sliderName;
  String sliderImg;
  String isEnable;
  DateTime createdAt;

  factory SlidersModel.fromJson(Map<String, dynamic> json) => SlidersModel(
    sliderId: json["slider_id"],
    sliderOrder: json["slider_order"],
    sliderName: json["slider_name"],
    sliderImg: json["slider_img"],
    isEnable: json["is_enable"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "slider_id": sliderId,
    "slider_order": sliderOrder,
    "slider_name": sliderName,
    "slider_img": sliderImg,
    "is_enable": isEnable,
    "created_at": createdAt.toIso8601String(),
  };
}
