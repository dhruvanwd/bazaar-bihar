import 'package:get/get.dart';
import 'package:orca_mob/models/ProductsModel.dart';
import 'package:orca_mob/models/ShopModels.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();
  late ShopModel shop;
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
