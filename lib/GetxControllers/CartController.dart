import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/GetxControllers/UserAddresses.dart';
import 'package:bazaar_bihar/models/CartModel.dart';
import 'package:bazaar_bihar/models/ShopModels.dart';
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
    product.cartItemCount++;
    updateCartState();
    update();
  }

  decrProductCount(ProductModel product) {
    if (product.cartItemCount > 1)
      product.cartItemCount--;
    else {
      Get.snackbar("Count Can't be 0", "Incr Product");
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
      print("updated existing cart");
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

  restoreOfflineCartData() {
    final Map? cartsJson =
        GlobalController.to.getStroageJson(EStorageKeys.CART);
    print("restoreOfflineCartData...........!");
    print(cartsJson);
    if (cartsJson != null) {
      final List cartsJsonList = List.from(cartsJson['cart']);
      cartsJsonList
          .forEach((cartJson) => {carts.add(CartModel.fromMap(cartJson))});
    }
  }

  @override
  void onInit() {
    Get.put(UserAddressesCtrl());
    restoreOfflineCartData();
    super.onInit();
  }
}
