import 'package:get/get.dart';
import 'package:bazaar_bihar/models/ProductsModel.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();
  var shop;
  List<ProductModel> products = [];

  addProduct(ProductModel product) {
    products.addIf(!products.contains(product), product);
    update();
  }

  removeProduct(ProductModel product) {
    products.removeWhere((element) => element.id == product.id);
    update();
  }
}
