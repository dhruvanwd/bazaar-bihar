import './ShopModels.dart';

import './CartAddressModel.dart';
import './ProductsModel.dart';

List<OrderModel> ordersModelFromMap(List<dynamic> order) =>
    List<OrderModel>.from(order.map((x) => OrderModel.fromJson(x)));

class OrderModel {
  OrderModel({
    required this.id,
    required this.status,
    required this.paymentId,
    required this.createdAt,
    required this.orderBy,
    required this.mrp,
    required this.sp,
    required this.deliveryAddress,
    required this.products,
    required this.shopId,
    required this.shop,
    required this.userName,
    this.rating,
    this.review,
  });

  String id;
  String paymentId;
  String status;
  String createdAt;
  String orderBy;
  String shopId;
  String userName;
  double mrp;
  double sp;
  ShopModel shop;
  List<ProductModel> products;
  CartAddressModel deliveryAddress;
  double? rating;
  String? review;

  get isRated => this.rating != null && this.review != null;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["_id"],
        products: productModelFromMap(json["products"]),
        status: json["status"],
        paymentId: json["paymentId"],
        createdAt: json["createdAt"],
        userName: json['userName'],
        rating: json['rating']?.toDouble() ?? null,
        review: json['review'],
        shop: ShopModel.fromJson(json['shop']),
        orderBy: json["orderBy"],
        mrp: json["mrp"].toDouble(),
        sp: json["sp"].toDouble(),
        shopId: json["shopId"],
        deliveryAddress: cartAddressModelFromJson(
          json['deliveryAddress'],
        ),
      );
}
