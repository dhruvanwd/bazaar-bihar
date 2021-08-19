// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'dart:convert';

import 'package:bazaar_bihar/models/ImagesModel.dart';

List<ProductModel> productModelFromMap(List<dynamic> products) =>
    List<ProductModel>.from(products.map((x) => ProductModel.fromMap(x)));

String productModelToMap(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.images,
    required this.markedPrice,
    required this.sellingPrice,
    required this.quantity,
    required this.description,
    required this.categoryId,
    required this.shopId,
    required this.isInStock,
    required this.unit,
  });

  String id;
  String name;
  List<ImageModel> images;
  String markedPrice;
  String sellingPrice;
  String quantity;
  String description;
  String categoryId;
  String shopId;
  bool isInStock;
  String unit;

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        name: json["name"],
        images: List<ImageModel>.from(
            json["images"].map((x) => ImageModel.fromJson(x))),
        markedPrice: json["markedPrice"],
        sellingPrice: json["sellingPrice"],
        quantity: json["quantity"],
        description: json["description"],
        categoryId: json["categoryId"],
        shopId: json["shopId"],
        isInStock: json["isInStock"],
        unit: json["unit"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "markedPrice": markedPrice,
        "sellingPrice": sellingPrice,
        "quantity": quantity,
        "description": description,
        "categoryId": categoryId,
        "shopId": shopId,
        "isInStock": isInStock,
        "unit": unit,
      };
}
