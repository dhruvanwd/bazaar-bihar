import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/components/CachedImageManager.dart';
import 'package:bazaar_bihar/components/ProductPriceInfo.dart';
import 'package:bazaar_bihar/models/ProductsModel.dart';
import 'package:bazaar_bihar/models/ShopModels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCartItem extends StatelessWidget {
  ProductCartItem(this.product, this.shop);
  final ProductModel product;
  final ShopModel shop;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        builder: (_cartCtrl) => Container(
              width: Get.mediaQuery.size.width,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 8),
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
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Card(
                          child: Row(
                            children: [
                              IconButton(
                                padding: EdgeInsets.all(0),
                                iconSize: 20,
                                onPressed: () {
                                  _cartCtrl.incrProductCount(product);
                                },
                                icon: Icon(Icons.add),
                              ),
                              Container(
                                child: Text(
                                  "${product.cartItemCount}",
                                  style: Get.theme.textTheme.subtitle1,
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.all(0),
                                iconSize: 20,
                                onPressed: () {
                                  _cartCtrl.decrProductCount(shop, product);
                                },
                                icon: product.cartItemCount == 1
                                    ? Icon(
                                        Icons.delete,
                                        color: Colors.deepOrange,
                                      )
                                    : Icon(Icons.remove),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                            "Total: ${double.parse(product.sellingPrice) * product.cartItemCount}"),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}
