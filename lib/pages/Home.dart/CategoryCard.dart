import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/components/CachedImageManager.dart';
import 'package:bazaar_bihar/models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends StatefulWidget {
  CategoryCard(this.cat);
  final CategoryModel cat;

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  final _ = GlobalController.to;
  @override
  Widget build(BuildContext context) {
    final CategoryModel cat = widget.cat;
    return SizedBox(
      width: 90,
      child: InkWell(
        onTap: () {
          _.fetchShops(cat.id);
          Get.toNamed('/shops', arguments: cat);
        },
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Colors.grey.shade200,
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                child: CachedImageMananger(cat.image),
                top: 0,
                left: 0,
                right: 0,
                bottom: 20,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.white60,
                  padding: EdgeInsets.symmetric(
                    vertical: 2,
                  ),
                  child: Center(
                    child: Text(
                      cat.name,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
