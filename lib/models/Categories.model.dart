// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

List<CategoriesModel> categoriesModelFromJson(String str) => List<CategoriesModel>.from(json.decode(str).map((x) => CategoriesModel.fromJson(x)));

String categoriesModelToJson(List<CategoriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesModel {
  CategoriesModel({
    required this.catId,
    required this.catImg,
    required this.catName,
    required this.parentCat,
    required this.catCreatedOn,
    required this.catUpdatedOn,
    required this.catFlag,
  });

  String catId;
  String catImg;
  String catName;
  String parentCat;
  DateTime catCreatedOn;
  DateTime catUpdatedOn;
  String catFlag;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    catId: json["cat_id"],
    catImg: json["cat_img"],
    catName: json["cat_name"],
    parentCat: json["parent_cat"],
    catCreatedOn: DateTime.parse(json["cat_created_on"]),
    catUpdatedOn: DateTime.parse(json["cat_updated_on"]),
    catFlag: json["cat_flag"],
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "cat_img": catImg,
    "cat_name": catName,
    "parent_cat": parentCat,
    "cat_created_on": catCreatedOn.toIso8601String(),
    "cat_updated_on": catUpdatedOn.toIso8601String(),
    "cat_flag": catFlag,
  };
}
