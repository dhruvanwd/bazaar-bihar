// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'dart:convert';

import 'CategoryModel.dart';
import 'ImagesModel.dart';

List<ProductModel> productModelFromMap(List<dynamic> products) =>
    List<ProductModel>.from(products.map((x) => ProductModel.fromMap(x)));

String productModelToMap(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ProductModel {
  ProductModel(
      {required this.id,
      required this.name,
      required this.images,
      required this.markedPrice,
      required this.sellingPrice,
      required this.quantity,
      required this.description,
      required this.category,
      required this.shopId,
      required this.isInStock,
      required this.unit,
      this.cartItemCount = 0});

  String id;
  String name;
  List<ImageModel> images;
  String markedPrice;
  String sellingPrice;
  String quantity;
  String description;
  CategoryModel category;
  String shopId;
  bool isInStock;
  String unit;
  int cartItemCount;

  get discount =>
      (((double.parse(this.markedPrice) - double.parse(this.sellingPrice)) /
                  double.parse(this.markedPrice)) *
              100)
          .toStringAsFixed(2);

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
      id: json["_id"],
      name: json["name"],
      images: List<ImageModel>.from(
          json["images"].map((x) => ImageModel.fromJson(x))),
      markedPrice: json["markedPrice"],
      sellingPrice: json["sellingPrice"],
      quantity: json["quantity"],
      description: json["description"],
      category: CategoryModel.fromMap(json["category"]),
      shopId: json["shopId"],
      isInStock: json["isInStock"],
      unit: json["unit"],
      cartItemCount: json['cartItemCount'] ?? 0);

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "markedPrice": markedPrice,
        "sellingPrice": sellingPrice,
        "quantity": quantity,
        "description": description,
        "category": category.toMap(),
        "shopId": shopId,
        "isInStock": isInStock,
        "unit": unit,
        "cartItemCount": cartItemCount
      };
}
