// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  NotificationModel({
    required this.notiId,
    required this.receiverType,
    required this.subject,
    required this.message,
    required this.time,
    required this.notiFlag,
  });

  String notiId;
  String receiverType;
  String subject;
  String message;
  String time;
  String notiFlag;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    notiId: json["noti_id"],
    receiverType: json["receiver_type"],
    subject: json["subject"],
    message: json["message"],
    time: json["time"],
    notiFlag: json["noti_flag"],
  );

  Map<String, dynamic> toJson() => {
    "noti_id": notiId,
    "receiver_type": receiverType,
    "subject": subject,
    "message": message,
    "time": time,
    "noti_flag": notiFlag,
  };
}
