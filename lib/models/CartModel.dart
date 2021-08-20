import 'package:bazaar_bihar/models/ProductsModel.dart';
import 'package:bazaar_bihar/models/ShopModels.dart';
import 'package:flutter/cupertino.dart';

class CartModel {
  CartModel({required this.shop});
  final ShopModel shop;
  final List<ProductModel> products = [];

  addProduct(ProductModel product) {
    if (!products.any((p) => p.id == product.id))
      products.add(product);
    else
      throw ErrorHint("Product already added.");
  }

  removeProduct(ProductModel product) {
    products.removeWhere((p) => p.id == product.id);
  }
}
