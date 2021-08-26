import 'package:bazaar_bihar/pages/Home.dart/CategoryCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';

class ShopByCategory extends StatelessWidget {
  ShopByCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      builder: (_) => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              "Shop by category",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _.categories
                  .map(
                    (cat) => CategoryCard(cat),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
