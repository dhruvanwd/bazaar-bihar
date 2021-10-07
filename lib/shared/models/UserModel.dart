// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.fullName,
    required this.mobile,
    required this.email,
    required this.role,
    required this.state,
    required this.city,
    required this.picture,
    required this.avatar,
    required this.id,
  });

  String fullName;
  String mobile;
  String? email;
  String role;
  String state;
  String city;
  String? picture;
  String? avatar;
  String id;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      fullName: json["fullName"],
      mobile: json["mobile"],
      email: json["email"],
      role: json["role"],
      state: json["state"],
      city: json["city"],
      picture: json["picture"],
      avatar: json["avatar"],
      id: json['_id']);

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "mobile": mobile,
        "email": email,
        "role": role,
        "state": state,
        "city": city,
        "picture": picture,
        "avatar": avatar,
        '_id': id
      };
}
