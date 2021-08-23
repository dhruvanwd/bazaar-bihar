import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/components/CachedImageManager.dart';
import 'package:bazaar_bihar/components/ProductPriceInfo.dart';
import 'package:bazaar_bihar/models/ProductsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCartItem extends StatelessWidget {
  ProductCartItem(this.product);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        builder: (_cartCtrl) => Container(
              margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 90,
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: CachedImageMananger(product.images[0]),
                  ),
                  Container(
                    width: Get.mediaQuery.size.width - 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            product.name,
                            style: Get.theme.textTheme.subtitle1!
                                .copyWith(color: Get.theme.primaryColor),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: ProductPriceInfo(product),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Row(
                      children: [
                        Container(
                          child: IconButton(
                              padding: EdgeInsets.all(0),
                              iconSize: 20,
                              onPressed: () {
                                _cartCtrl.incrProductCount(product);
                              },
                              icon: Icon(Icons.add)),
                        ),
                        Container(
                          child: Text(
                            "${product.cartItemCount}",
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        Container(
                          child: IconButton(
                            padding: EdgeInsets.all(0),
                            iconSize: 20,
                            onPressed: () {
                              _cartCtrl.decrProductCount(product);
                            },
                            icon: Icon(Icons.remove),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
