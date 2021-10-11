import '../Utils/utils.dart';
import '../components/CarouselWithIndicator.dart';
import '../components/ProductPriceInfo.dart';
import '../models/ProductsModel.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/extensions.dart';

class DenseProductCard extends StatelessWidget {
  final ProductModel currentProduct;
  final bool isOrdered;
  final List<Widget> sellerActions;
  DenseProductCard(this.currentProduct,
      {required this.isOrdered, this.sellerActions = const []});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: Get.mediaQuery.size.width,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: CarouselWithIndicator(
                        currentProduct.images,
                        aspectRatio: 1.04,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
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
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: ProductPriceInfo(currentProduct),
                          ),
                          Container(
                            child: EasyRichText(
                              "${calculateDiscount(currentProduct.markedPrice, currentProduct.sellingPrice)}% discount",
                              patternList: [
                                EasyRichTextPattern(
                                  targetString: calculateDiscount(
                                      currentProduct.markedPrice,
                                      currentProduct.sellingPrice),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (isOrdered) ...[
                            Container(
                              padding: EdgeInsets.only(top: 8),
                              child: EasyRichText(
                                "Total = ",
                                patternList: [
                                  EasyRichTextPattern(
                                    targetString: "Total = ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 4),
                              child: EasyRichText(
                                "${currentProduct.cartItemCount} X $rupeeSymbol ${currentProduct.sellingPrice} = $rupeeSymbol ${currentProduct.cartItemCount * double.parse(currentProduct.sellingPrice)}",
                                patternList: [
                                  EasyRichTextPattern(
                                    targetString: calculateDiscount(
                                        currentProduct.markedPrice,
                                        currentProduct.sellingPrice),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  EasyRichTextPattern(
                                    targetString: rupeeSymbol,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ] else
                            ...sellerActions
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
