import 'package:bazaar_bihar/models/ShopModels.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/CartController.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/models/ProductsModel.dart';

class ProductCard extends StatelessWidget {
  final ProductModel currentProduct;
  ProductCard(this.currentProduct);
  final ShopModel _shop = Get.arguments;

  final _ = GlobalController.to;

  @override
  Widget build(BuildContext context) {
    print(_shop);
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    aspectRatio: 1,
                    enableInfiniteScroll: false,
                    height: 250,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  ),
                  items: currentProduct.images
                      .map(
                        (image) => Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            _.createImageUrl(image),
                          ),
                        ),
                      )
                      .toList()),
              Row(
                children: [
                  Expanded(
                    child: Column(
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
                                  currentProduct.name,
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
                          child: Row(
                            children: [
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    text:
                                        'MRP: ₹${currentProduct.markedPrice} ',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.red.shade500,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            ' SP: ₹${currentProduct.sellingPrice}',
                                        style: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.purple,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 4),
                    child: GetBuilder<CartController>(
                      builder: (_cartCtrl) {
                        final bool isAddedToCart = _cartCtrl.products
                            .any((p) => p.id == currentProduct.id);
                        return IconButton(
                          color: Colors.deepOrange,
                          onPressed: () {
                            if (isAddedToCart) {
                              _cartCtrl.removeProduct(currentProduct);
                            } else
                              _cartCtrl.addProduct(currentProduct);
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
      ),
    );
  }
}
