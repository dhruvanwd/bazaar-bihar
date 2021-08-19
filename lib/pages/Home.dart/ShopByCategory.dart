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
                    (cat) => SizedBox(
                      width: 90,
                      child: InkWell(
                        onTap: () {
                          _.fetchShops(cat.id);
                          Get.toNamed('/shops');
                        },
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          color: Colors.grey.shade200,
                          elevation: 2,
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      _.createImageUrl(cat.image),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Text(cat.name),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
