import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orca_mob/GetxControllers/GlobalController.dart';

class HomePage extends StatelessWidget {
  final globalController = Get.find<GlobalController>();
  HomePage({Key? key}) {
    globalController.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
          actions: [
            IconButton(
              onPressed: _.logout,
              icon: Icon(
                Icons.logout,
              ),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "Shop by category",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _.categories
                      .map(
                        (e) => Card(
                          clipBehavior: Clip.hardEdge,
                          color: Colors.grey.shade300,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image(
                                  image: NetworkImage(
                                    _.createImageUrl(e['image']),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Center(
                                  child: Text(e['name']),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
