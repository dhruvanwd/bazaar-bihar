import 'package:bazaar_bihar/pages/OrdersPage/CarouselWithIndicator.dart';
import 'package:bazaar_bihar/shared/Utils/extensions.dart';
import 'package:bazaar_bihar/shared/components/ProductPriceInfo.dart';
import 'package:bazaar_bihar/shared/models/ProductsModel.dart';
import 'package:bazaar_bihar/shared/models/ShopModels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/CartController.dart';

class ProductCard extends StatelessWidget {
  final ProductModel currentProduct;
  ProductCard(this.currentProduct);

  @override
  Widget build(BuildContext context) {
    final ShopModel _shop = Get.arguments;
    return Card(
      margin: EdgeInsets.only(bottom: 16, right: 8, left: 8),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselWithIndicator(currentProduct.images),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Text(
                                currentProduct.name.inCaps,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.orange.shade500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              '(${currentProduct.quantity} ${currentProduct.unit})',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.blueGrey.shade300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ProductPriceInfo(currentProduct),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 4),
                  child: GetBuilder<CartController>(
                    builder: (_cartCtrl) {
                      final bool isAddedToCart =
                          _cartCtrl.isproductAdded(_shop, currentProduct);
                      return IconButton(
                        color: Colors.deepOrange,
                        onPressed: () {
                          if (isAddedToCart) {
                            _cartCtrl.removeProduct(_shop, currentProduct);
                          } else
                            _cartCtrl.addProduct(_shop, currentProduct);
                        },
                        icon: isAddedToCart
                            ? Icon(
                                Icons.remove_shopping_cart,
                              )
                            : Icon(
                                MaterialCommunityIcons.cart_plus,
                              ),
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
