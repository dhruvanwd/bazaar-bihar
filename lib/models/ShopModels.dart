// To parse this JSON data, do
//
//     final shopModel = shopModelFromJson(jsonString);

import 'dart:convert';

import 'package:bazaar_bihar/models/ImagesModel.dart';

List<ShopModel> shopModelFromJson(List<dynamic> shopsJson) =>
    List<ShopModel>.from(shopsJson.map((x) => ShopModel.fromJson(x)));

String shopModelToJson(List<ShopModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShopModel {
  ShopModel({
    required this.id,
    required this.images,
    required this.name,
    required this.categoryId,
    required this.addressLine1,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.productCollectionNm,
    required this.ownerId,
  });

  String id;
  List<ImageModel> images;
  String name;
  String categoryId;
  String addressLine1;
  String state;
  String city;
  String pinCode;
  String productCollectionNm;
  String ownerId;

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json["_id"],
        images: List<ImageModel>.from(
            json["images"].map((x) => ImageModel.fromJson(x))),
        name: json["name"],
        categoryId: json["categoryId"],
        addressLine1: json["addressLine1"],
        state: json["state"],
        city: json["city"],
        pinCode: json["pinCode"],
        productCollectionNm: json["productCollectionNm"],
        ownerId: json["ownerId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "name": name,
        "categoryId": categoryId,
        "addressLine1": addressLine1,
        "state": state,
        "city": city,
        "pinCode": pinCode,
        "productCollectionNm": productCollectionNm,
        "ownerId": ownerId,
      };
}
