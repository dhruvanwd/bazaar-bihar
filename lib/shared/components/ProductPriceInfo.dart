import 'package:flutter/material.dart';
import '../models/ProductsModel.dart';

class ProductPriceInfo extends StatelessWidget {
  const ProductPriceInfo(this.currentProduct);
  final ProductModel currentProduct;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      runSpacing: 5,
      children: [
        Text(
          'MRP: ₹${currentProduct.markedPrice} ',
          style: TextStyle(
            decoration: TextDecoration.lineThrough,
            decorationColor: Colors.red.shade500,
          ),
        ),
        Text(
          'SP: ₹${currentProduct.sellingPrice}',
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.purple,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
