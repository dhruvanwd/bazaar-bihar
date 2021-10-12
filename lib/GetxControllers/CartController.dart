import 'package:bazaar_bihar/generic/OfflineStorage.dart';
import 'package:bazaar_bihar/shared/Utils/utils.dart';
import 'package:bazaar_bihar/shared/models/CartModel.dart';
import 'package:bazaar_bihar/shared/models/PaymentInfoModal.dart';
import 'package:bazaar_bihar/shared/models/ProductsModel.dart';
import 'package:bazaar_bihar/shared/models/ShopModels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();
  final OfflineStorage offlineStorage = OfflineStorage();
  List<CartModel> carts = [];

  updateCartState() {
    final cartsJsonList = carts.map((cart) => cart.toJson()).toList();
    print(cartsJsonList);
    offlineStorage.updateStorage(EStorageKeys.CART, {"cart": cartsJsonList});
  }

  removeCartItem(String shopName) {
    print(shopName);
    carts.removeWhere((cart) => cart.shop.name == shopName);
    update();
  }

  incrProductCount(ProductModel product) {
    if (product.cartItemCount > 9) {
      Get.snackbar("Max Limit", 'maximum 10 items allowed !',
          colorText: Colors.purple, snackPosition: SnackPosition.BOTTOM);
    } else
      product.cartItemCount++;
    updateCartState();
    update();
  }

  PaymentInfoModal getOrderPriceSummary() {
    double totalMrp = 0.0;
    double totalSp = 0.0;
    List<Map<dynamic, dynamic>> shopWiseInfo = [];
    carts.forEach((cart) {
      final shopInfo = Map.from({
        "shopName": cart.shop.name,
        "shopId": cart.shop.id,
        'mrp': 0,
        'sp': 0
      });
      cart.products.forEach((product) {
        double mrp = double.parse(product.markedPrice) * product.cartItemCount;
        shopInfo['mrp'] += mrp;
        totalMrp += mrp;
        final double sp =
            double.parse(product.sellingPrice) * product.cartItemCount;
        shopInfo['sp'] += sp;
        totalSp += sp;
        muliPrint(["mrp", shopInfo['mrp'], "sp", shopInfo['sp']]);
      });
      shopWiseInfo.add(shopInfo);
    });

    return PaymentInfoModal.fromJson({
      "totalMrp": totalMrp,
      "totalSp": totalSp,
      "shopWiseInfo": shopWiseInfo
    });
  }

  decrProductCount(ShopModel shop, ProductModel product) {
    if (product.cartItemCount > 1)
      product.cartItemCount--;
    else {
      removeProduct(shop, product);
    }
    updateCartState();
    update();
  }

  bool isproductAdded(ShopModel shop, ProductModel product) {
    try {
      final tempCart = carts.firstWhere((cart) => cart.shop.id == shop.id);
      tempCart.products.firstWhere((p) => p.id == product.id);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  addProduct(ShopModel shop, ProductModel product) {
    try {
      CartModel foundCart = carts.firstWhere((cart) => cart.shop.id == shop.id);
      product.cartItemCount++;
      foundCart.addProduct(product);
    } catch (e) {
      final tempCartModel = CartModel(shop: shop, products: []);
      tempCartModel.addProduct(product);
      product.cartItemCount++;
      carts.add(tempCartModel);
      print("created new cart with products");
    }
    updateCartState();
    update();
  }

  removeProduct(ShopModel shop, ProductModel product) {
    try {
      CartModel foundCart = carts.firstWhere((cart) => cart.shop.id == shop.id);
      foundCart.removeProduct(product);
      print("product deleted successfully...!");
      if (foundCart.products.length == 0) {
        carts.removeWhere((cart) => cart.shop.id == shop.id);
        print("cart shop with empty products");
        print("removing shop from cart");
      }
    } catch (e) {
      print("This product is not added to cart");
    }
    updateCartState();
    update();
  }

  emptyCart() {
    carts = [];
    updateCartState();
    update();
  }

  restoreOfflineCartData() {
    final Map? cartsJson = offlineStorage.getStroageJson(EStorageKeys.CART);
    if (cartsJson != null) {
      final List cartsJsonList = List.from(cartsJson['cart']);
      cartsJsonList
          .forEach((cartJson) => {carts.add(CartModel.fromMap(cartJson))});
    }
  }

  @override
  void onInit() {
    restoreOfflineCartData();
    super.onInit();
  }
}
