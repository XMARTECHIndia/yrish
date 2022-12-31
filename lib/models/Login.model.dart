import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.id,
    required this.sessionKey,
  });

  String id;
  String sessionKey;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    id: json["id"],
    sessionKey: json["session_key"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "session_key": sessionKey,
  };
}