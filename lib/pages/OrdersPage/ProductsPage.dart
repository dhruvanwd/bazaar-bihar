import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:orca_mob/components/FloatingCartButton.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Name'),
      ),
      floatingActionButton: FloatingCartButton(
        parentContext: context,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(bottom: 16),
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      aspectRatio: 1,
                      enableInfiniteScroll: false,
                      height: 330,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    ),
                    items: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'images/carrots.jpg',
                              fit: BoxFit.cover,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 8),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                              child: Text(
                                                'Maggi (Chicken)',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.orange.shade500,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '1 per packet',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.blueGrey.shade300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text.rich(
                                                TextSpan(
                                                  text: 'MRP: ₹500 ',
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationColor:
                                                        Colors.red.shade500,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: ' SP: ₹450',
                                                      style: TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        color: Colors.purple,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                  padding: EdgeInsets.only(right: 8),
                                  child: IconButton(
                                    color: Colors.deepOrange,
                                    onPressed: () {},
                                    icon: Icon(
                                      MaterialCommunityIcons.cart_plus,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
