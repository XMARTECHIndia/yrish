// To parse this JSON data, do
//
//     final deliveryAddressModel = deliveryAddressModelFromJson(jsonString);

import 'dart:convert';

List<DeliveryAddressModel> deliveryAddressModelFromJson(String str) => List<DeliveryAddressModel>.from(json.decode(str).map((x) => DeliveryAddressModel.fromJson(x)));

String deliveryAddressModelToJson(List<DeliveryAddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliveryAddressModel {
  DeliveryAddressModel({
    required this.haLineOne,
    required this.haLineTwo,
    required this.haLandMark,
    required this.haPhone,
    required this.haPinCode,
    required this.haCity,
    required this.haState,
    required this.haFlag,
    required this.waLineOne,
    required this.waLineTwo,
    required this.waLandMark,
    required this.waPhone,
    required this.waPinCode,
    required this.waCity,
    required this.waState,
    required this.waFlag,
  });

  String haLineOne;
  String haLineTwo;
  String haLandMark;
  String haPhone;
  String haPinCode;
  String haCity;
  String haState;
  String haFlag;
  String waLineOne;
  String waLineTwo;
  String waLandMark;
  String waPhone;
  String waPinCode;
  String waCity;
  String waState;
  String waFlag;

  factory DeliveryAddressModel.fromJson(Map<String, dynamic> json) => DeliveryAddressModel(
    haLineOne: json["ha_line_one"],
    haLineTwo: json["ha_line_two"],
    haLandMark: json["ha_land_mark"],
    haPhone: json["ha_phone"],
    haPinCode: json["ha_pin_code"],
    haCity: json["ha_city"],
    haState: json["ha_state"],
    haFlag: json["ha_flag"],
    waLineOne: json["wa_line_one"],
    waLineTwo: json["wa_line_two"],
    waLandMark: json["wa_land_mark"],
    waPhone: json["wa_phone"],
    waPinCode: json["wa_pin_code"],
    waCity: json["wa_city"],
    waState: json["wa_state"],
    waFlag: json["wa_flag"],
  );

  Map<String, dynamic> toJson() => {
    "ha_line_one": haLineOne,
    "ha_line_two": haLineTwo,
    "ha_land_mark": haLandMark,
    "ha_phone": haPhone,
    "ha_pin_code": haPinCode,
    "ha_city": haCity,
    "ha_state": haState,
    "ha_flag": haFlag,
    "wa_line_one": waLineOne,
    "wa_line_two": waLineTwo,
    "wa_land_mark": waLandMark,
    "wa_phone": waPhone,
    "wa_pin_code": waPinCode,
    "wa_city": waCity,
    "wa_state": waState,
    "wa_flag": waFlag,
  };
}
