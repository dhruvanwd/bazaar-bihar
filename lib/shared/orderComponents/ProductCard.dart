import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/cupertino.dart';

import '../Utils/extensions.dart';
import '../Utils/utils.dart';
import '../components/ProductPriceInfo.dart';
import '../models/ProductsModel.dart';
import '../components/CarouselWithIndicator.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel currentProduct;
  ProductCard(this.currentProduct);

  @override
  Widget build(BuildContext context) {
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
                  child: Container(
                    padding: EdgeInsets.only(bottom: 4),
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
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 8),
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
                              ))
                        ],
                      ),
                    ),
                    currentProduct.manageInventory != null &&
                            currentProduct.manageInventory!
                        ? Container(
                            padding: EdgeInsets.only(top: 8, right: 8),
                            child: EasyRichText(
                              "${currentProduct.availableCount} units in stock",
                              patternList: [
                                EasyRichTextPattern(
                                  targetString: currentProduct.availableCount,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
