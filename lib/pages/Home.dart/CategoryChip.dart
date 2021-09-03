import 'package:bazaar_bihar/GetxControllers/GlobalController.dart';
import 'package:bazaar_bihar/components/CachedImageManager.dart';
import 'package:bazaar_bihar/models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryChip extends StatelessWidget {
  final _ = GlobalController.to;
  final CategoryModel cat;
  CategoryChip(this.cat);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        elevation: 8.0,
        padding: EdgeInsets.all(2.0),
        avatar: CircleAvatar(
          backgroundColor: Colors.white,
          child: CachedImageMananger(cat.image),
        ),
        label: Text(
          cat.name,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
        onPressed: () {
          _.clearCurrentShop();
          _.fetchShops(cat.id);
          Get.toNamed('/shops', arguments: cat);
        },
        backgroundColor: Colors.white,
        shape: StadiumBorder(
            side: BorderSide(
          width: 1,
          color: Get.theme.primaryColor,
        )),
      ),
    );
  }
}
