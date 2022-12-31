// To parse this JSON data, do
//
//     final userdataModel = userdataModelFromJson(jsonString);

import 'dart:convert';

List<UserdataModel> userdataModelFromJson(String str) => List<UserdataModel>.from(json.decode(str).map((x) => UserdataModel.fromJson(x)));

String userdataModelToJson(List<UserdataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserdataModel {
  UserdataModel({
    required this.usrId,
    required this.usrName,
    required this.usrEmailId,
    required this.usrState,
    required this.usrPincode,
    required this.userOccupation,
    required this.usrPhone,
    required this.usrAlt,
    required this.usrRefCode,
    required this.usrRefBy,
  });

  String usrId;
  String usrName;
  String usrEmailId;
  String usrState;
  String usrPincode;
  String userOccupation;
  String usrPhone;
  String usrAlt;
  String usrRefCode;
  String usrRefBy;

  factory UserdataModel.fromJson(Map<String, dynamic> json) => UserdataModel(
    usrId: json["usr_id"],
    usrName: json["usr_name"],
    usrEmailId: json["usr_email_id"],
    usrState: json["usr_state"],
    usrPincode: json["usr_pincode"],
    userOccupation: json["user_occupation"],
    usrPhone: json["usr_phone"],
    usrAlt: json["usr_alt"],
    usrRefCode: json["usr_ref_code"],
    usrRefBy: json["usr_ref_by"],
  );

  Map<String, dynamic> toJson() => {
    "usr_id": usrId,
    "usr_name": usrName,
    "usr_email_id": usrEmailId,
    "usr_state": usrState,
    "usr_pincode": usrPincode,
    "user_occupation": userOccupation,
    "usr_phone": usrPhone,
    "usr_alt": usrAlt,
    "usr_ref_code": usrRefCode,
    "usr_ref_by": usrRefBy,
  };
}
