import 'package:bazaar_bihar/models/ProductsModel.dart';
import 'package:flutter/material.dart';

class ProductPriceInfo extends StatelessWidget {
  const ProductPriceInfo(this.currentProduct);
  final ProductModel currentProduct;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              text: 'MRP: ₹${currentProduct.markedPrice} ',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.red.shade500,
              ),
              children: [
                TextSpan(
                  text: ' SP: ₹${currentProduct.sellingPrice}',
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
    );
  }
}
