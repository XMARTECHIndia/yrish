// To parse this JSON data, do
//
//     final invoiceModel = invoiceModelFromJson(jsonString);

import 'dart:convert';

List<InvoiceModel> invoiceModelFromJson(String str) => List<InvoiceModel>.from(json.decode(str).map((x) => InvoiceModel.fromJson(x)));

String invoiceModelToJson(List<InvoiceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoiceModel {
  InvoiceModel({
    required this.orderId,
    required this.usrId,
    required this.billToName,
    required this.billToAddress,
    required this.billToPhone,
    required this.billToGstin,
    required this.billDate,
    required this.invoiceTotal,
    required this.discountAmt,
    required this.payableAmt,
    required this.coinAmt,
    required this.invoiceSgst,
    required this.invoiceCgst,
    required this.payMode,
    required this.payStatus,
    required this.payStatusOn,
    required this.transactionId,
    required this.couponName,
    required this.delvAddress,
    required this.delvPincode,
    required this.expDelvOn,
    required this.delvStatus,
    required this.delvStatusNote,
    required this.delvStatusOn,
    required this.coinEarn,
    required this.orderFlag,
  });

  String orderId;
  String usrId;
  String billToName;
  String billToAddress;
  String billToPhone;
  String billToGstin;
  DateTime billDate;
  String invoiceTotal;
  String discountAmt;
  String payableAmt;
  String coinAmt;
  String invoiceSgst;
  String invoiceCgst;
  String payMode;
  String payStatus;
  DateTime payStatusOn;
  String transactionId;
  String couponName;
  String delvAddress;
  String delvPincode;
  DateTime expDelvOn;
  String delvStatus;
  String delvStatusNote;
  DateTime delvStatusOn;
  String coinEarn;
  String orderFlag;

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
    orderId: json["order_id"],
    usrId: json["usr_id"],
    billToName: json["bill_to_name"],
    billToAddress: json["bill_to_address"],
    billToPhone: json["bill_to_phone"],
    billToGstin: json["bill_to_gstin"],
    billDate: DateTime.parse(json["bill_date"]),
    invoiceTotal: json["invoice_total"],
    discountAmt: json["discount_amt"],
    payableAmt: json["payable_amt"],
    coinAmt: json["coin_amt"],
    invoiceSgst: json["invoice_sgst"],
    invoiceCgst: json["invoice_cgst"],
    payMode: json["pay_mode"],
    payStatus: json["pay_status"],
    payStatusOn: DateTime.parse(json["pay_status_on"]),
    transactionId: json["transaction_id"],
    couponName: json["coupon_name"],
    delvAddress: json["delv_address"],
    delvPincode: json["delv_pincode"],
    expDelvOn: DateTime.parse(json["exp_delv_on"]),
    delvStatus: json["delv_status"],
    delvStatusNote: json["delv_status_note"],
    delvStatusOn: DateTime.parse(json["delv_status_on"]),
    coinEarn: json["coin_earn"],
    orderFlag: json["order_flag"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "usr_id": usrId,
    "bill_to_name": billToName,
    "bill_to_address": billToAddress,
    "bill_to_phone": billToPhone,
    "bill_to_gstin": billToGstin,
    "bill_date": billDate.toIso8601String(),
    "invoice_total": invoiceTotal,
    "discount_amt": discountAmt,
    "payable_amt": payableAmt,
    "coin_amt": coinAmt,
    "invoice_sgst": invoiceSgst,
    "invoice_cgst": invoiceCgst,
    "pay_mode": payMode,
    "pay_status": payStatus,
    "pay_status_on": payStatusOn.toIso8601String(),
    "transaction_id": transactionId,
    "coupon_name": couponName,
    "delv_address": delvAddress,
    "delv_pincode": delvPincode,
    "exp_delv_on": "${expDelvOn.year.toString().padLeft(4, '0')}-${expDelvOn.month.toString().padLeft(2, '0')}-${expDelvOn.day.toString().padLeft(2, '0')}",
    "delv_status": delvStatus,
    "delv_status_note": delvStatusNote,
    "delv_status_on": delvStatusOn.toIso8601String(),
    "coin_earn": coinEarn,
    "order_flag": orderFlag,
  };
}
