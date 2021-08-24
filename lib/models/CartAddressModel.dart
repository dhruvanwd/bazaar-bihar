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
    required this.streetName,
    required this.nearBy,
  });

  String city;
  String state;
  String destinationContact;
  String addressLine1;
  String zipCode;
  String streetName;
  String nearBy;

  factory CartAddressModel.fromJson(Map<String, dynamic> json) =>
      CartAddressModel(
        city: json["city"],
        state: json["state"],
        destinationContact: json["destinationContact"],
        addressLine1: json["AddressLine1"],
        zipCode: json["zipCode"],
        streetName: json["streetName"],
        nearBy: json["nearBy"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "destinationContact": destinationContact,
        "AddressLine1": addressLine1,
        "zipCode": zipCode,
        "streetName": streetName,
        "nearBy": nearBy,
      };
}
