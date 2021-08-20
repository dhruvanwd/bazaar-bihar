import 'package:bazaar_bihar/models/CartModel.dart';
import 'package:bazaar_bihar/models/ShopModels.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/models/ProductsModel.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();
  List<CartModel> carts = [];

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
      foundCart.addProduct(product);
      print("updated existing cart");
    } catch (e) {
      final tempCartModel = CartModel(shop: shop);
      tempCartModel.addProduct(product);
      carts.add(tempCartModel);
      print("created new cart with products");
    }
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

    update();
  }
}
