// To parse this JSON data, do
//
//     final cartAddressModel = cartAddressModelFromJson(jsonString);

import 'dart:convert';

CartAddressModel cartAddressModelFromJson(Map<String, dynamic> address) =>
    CartAddressModel.fromJson(address);

Object cartAddressModelToJson(CartAddressModel data) => data.toJson();

class CartAddressModel {
  CartAddressModel({
    required this.city,
    required this.state,
    required this.destinationContact,
    required this.addressLine1,
    required this.zipCode,
    required this.locality,
    required this.receiverName,
  });

  String city;
  String state;
  String destinationContact;
  String addressLine1;
  String zipCode;
  String locality;
  String receiverName;

  factory CartAddressModel.fromJson(Map<String, dynamic> json) =>
      CartAddressModel(
          city: json["city"],
          state: json["state"],
          destinationContact: json["destinationContact"],
          addressLine1: json["addressLine1"],
          zipCode: json["zipCode"],
          locality: json["locality"],
          receiverName: json['receiverName']);

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "destinationContact": destinationContact,
        "addressLine1": addressLine1,
        "zipCode": zipCode,
        "locality": locality,
        "receiverName": receiverName
      };
}
