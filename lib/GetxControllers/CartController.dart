import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/GetxControllers/PaymentController.dart';
import 'package:bazaar_bihar/GetxControllers/CartAddressController.dart';
import 'package:bazaar_bihar/models/CartModel.dart';
import 'package:bazaar_bihar/models/PaymentInfoModal.dart';
import 'package:bazaar_bihar/models/ShopModels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/models/ProductsModel.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();
  List<CartModel> carts = [];

  updateCartState() {
    final cartsJsonList = carts.map((cart) => cart.toJson()).toList();
    print(cartsJsonList);
    GlobalController.to
        .updateStorage(EStorageKeys.CART, {"cart": cartsJsonList});
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
      final shopInfo = Map.from({"shopName": cart.shop.name});
      cart.products.forEach((product) {
        double mrp = double.parse(product.markedPrice) * product.cartItemCount;
        shopInfo['mrp'] = mrp;
        totalMrp += mrp;
        final double sp =
            double.parse(product.sellingPrice) * product.cartItemCount;
        shopInfo['sp'] = sp;
        totalSp += sp;
      });
      shopWiseInfo.add(shopInfo);
    });

    return PaymentInfoModal.fromJson(Map.from({
      "totalMrp": totalMrp,
      "totalSp": totalSp,
      "shopWiseInfo": shopWiseInfo
    }));
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
    final Map? cartsJson =
        GlobalController.to.getStroageJson(EStorageKeys.CART);
    if (cartsJson != null) {
      final List cartsJsonList = List.from(cartsJson['cart']);
      cartsJsonList
          .forEach((cartJson) => {carts.add(CartModel.fromMap(cartJson))});
    }
  }

  @override
  void onInit() {
    Get.put(CartAddressController());
    Get.put(PaymentController());
    restoreOfflineCartData();
    super.onInit();
  }
}
