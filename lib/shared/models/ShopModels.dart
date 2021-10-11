// To parse this JSON data, do
//
//     final shopModel = shopModelFromJson(jsonString);

import 'dart:convert';

import './CategoryModel.dart';

import 'ImagesModel.dart';

List<ShopModel> shopModelFromJson(List<dynamic> shopsJson) =>
    List<ShopModel>.from(shopsJson.map((x) => ShopModel.fromJson(x)));

String shopModelToJson(List<ShopModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShopModel {
  ShopModel({
    required this.id,
    required this.images,
    required this.name,
    required this.category,
    required this.addressLine1,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.ownerId,
    required this.allowPickups,
    required this.payOnDelivery,
    required this.weekDays,
    required this.operatingTime,
  });

  String id;
  List<ImageModel> images;
  String name;
  CategoryModel category;
  String addressLine1;
  String state;
  String city;
  String pinCode;
  String ownerId;
  bool allowPickups;
  bool payOnDelivery;
  List<String> weekDays;
  Map<String, String> operatingTime;
  // Keys = ['start', 'end']

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json["_id"],
        images: List<ImageModel>.from(
            json["images"].map((x) => ImageModel.fromJson(x))),
        name: json["name"],
        category: CategoryModel.fromMap(json["category"]),
        addressLine1: json["addressLine1"],
        state: json["state"],
        city: json["city"],
        pinCode: json["pinCode"],
        ownerId: json["ownerId"],
        allowPickups: json['allowPickups'] ?? false,
        payOnDelivery: json['payOnDelivery'] ?? false,
        weekDays: List<String>.from(json['weekDays'] ?? const <List<String>>[]),
        operatingTime: json["operatingTime"] != null
            ? Map<String, String>.from(json["operatingTime"])
            : Map<String, String>.from(
                {"start": "09:00 AM", "end": "09:00 PM"}),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "name": name,
        "category": category.toMap(),
        "addressLine1": addressLine1,
        "state": state,
        "city": city,
        "pinCode": pinCode,
        "ownerId": ownerId,
        "allowPickups": allowPickups,
        "payOnDelivery": payOnDelivery,
        "weekDays": weekDays,
        "operatingTime": operatingTime
      };
}
