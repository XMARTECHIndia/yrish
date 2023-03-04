// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

List<OrderDetailsModel> orderDetailsModelFromJson(String str) => List<OrderDetailsModel>.from(json.decode(str).map((x) => OrderDetailsModel.fromJson(x)));

String orderDetailsModelToJson(List<OrderDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetailsModel {
  OrderDetailsModel({
    required this.orderId,
    required this.itemId,
    required this.itemName,
    required this.itemDesc,
    required this.itemHsn,
    required this.itemRate,
    required this.itemQty,
    required this.itemAmount,
    required this.itemSgst,
    required this.itemCgst,
    required this.invFlag,
  });

  String orderId;
  String itemId;
  String itemName;
  String itemDesc;
  String itemHsn;
  String itemRate;
  String itemQty;
  String itemAmount;
  String itemSgst;
  String itemCgst;
  String invFlag;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    orderId: json["order_id"],
    itemId: json["item_id"],
    itemName: json["item_name"],
    itemDesc: json["item_desc"],
    itemHsn: json["item_hsn"],
    itemRate: json["item_rate"],
    itemQty: json["item_qty"],
    itemAmount: json["item_amount"],
    itemSgst: json["item_sgst"],
    itemCgst: json["item_cgst"],
    invFlag: json["inv_flag"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "item_id": itemId,
    "item_name": itemName,
    "item_desc": itemDesc,
    "item_hsn": itemHsn,
    "item_rate": itemRate,
    "item_qty": itemQty,
    "item_amount": itemAmount,
    "item_sgst": itemSgst,
    "item_cgst": itemCgst,
    "inv_flag": invFlag,
  };
}
