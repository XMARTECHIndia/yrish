// To parse this JSON data, do
//
//     final parentcatModel = parentcatModelFromJson(jsonString);

import 'dart:convert';

List<ParentcatModel> parentcatModelFromJson(String str) => List<ParentcatModel>.from(json.decode(str).map((x) => ParentcatModel.fromJson(x)));

String parentcatModelToJson(List<ParentcatModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParentcatModel {
  ParentcatModel({
    required this.catName,
    required this.parentCat,
  });

  String catName;
  String parentCat;

  factory ParentcatModel.fromJson(Map<String, dynamic> json) => ParentcatModel(
    catName: json["cat_name"],
    parentCat: json["parent_cat"],
  );

  Map<String, dynamic> toJson() => {
    "cat_name": catName,
    "parent_cat": parentCat,
  };
}
