import 'package:flutter/cupertino.dart';

import 'ShopModels.dart';
import './ProductsModel.dart';

class CartModel {
  CartModel({required this.shop, required this.products});
  final ShopModel shop;
  final List<ProductModel> products;

  addProduct(ProductModel product) {
    if (!products.any((p) => p.id == product.id))
      products.add(product);
    else
      throw ErrorHint("Product already added.");
  }

  toJson() {
    return {
      "shop": shop.toJson(),
      "products": products.map((p) => p.toMap()).toList()
    };
  }

  factory CartModel.fromMap(dynamic json) {
    final List productsMapList = json['products'];
    return CartModel(
        shop: ShopModel.fromJson(json["shop"]),
        products: productModelFromMap(productsMapList).toList());
  }
  removeProduct(ProductModel product) {
    products.removeWhere((p) => p.id == product.id);
  }
}
