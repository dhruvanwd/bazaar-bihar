// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromMap(jsonString);

import 'dart:convert';

import './ImagesModel.dart';

List<CategoryModel> categoryModelFromMap(List<dynamic> categories) =>
    List<CategoryModel>.from(categories.map((x) => CategoryModel.fromMap(x)));

String categoryModelToMap(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  String id;
  String name;
  ImageModel image;

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        name: json["name"],
        image: ImageModel.fromJson(json["image"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "image": image.toJson(),
      };
}
