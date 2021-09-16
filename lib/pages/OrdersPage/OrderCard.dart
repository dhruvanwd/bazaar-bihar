import 'package:bazaar_bihar/Utils/utils.dart';
import 'package:bazaar_bihar/models/CartModel.dart';
import 'package:bazaar_bihar/pages/OrdersPage/CarouselWithIndicator.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final Map orderDetail;
  OrderCard(this.orderDetail);

  @override
  Widget build(BuildContext context) {
    final CartModel order = CartModel.fromMap(orderDetail);
    print(orderDetail);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL, // default
        front: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            color: Colors.brown.shade700,
            child: Column(
              children: [
                Stack(
                  children: [
                    CarouselWithIndicator(order.shop.images),
                    Positioned(
                        left: -50,
                        top: 25,
                        child: RotationTransition(
                          turns: new AlwaysStoppedAnimation(320 / 360),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 3),
                            decoration: BoxDecoration(color: Colors.white),
                            child: Center(
                              child: Text(
                                "Order Placed",
                                style: Get.theme.textTheme.subtitle2,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 2, color: Colors.grey.shade400),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      order.shop.name,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      orderDetail['createdAt'],
                      style: TextStyle(
                        color: Colors.blueGrey.shade100,
                      ),
                    ),
                    trailing: Text(
                      '$rupeeSymbol${orderDetail["mrp"]}',
                      style: TextStyle(
                        color: Colors.blue.shade400,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        back: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            height: 350,
            color: Colors.cyan.shade100,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: ListView.custom(
                      childrenDelegate: SliverChildBuilderDelegate(
                        (_, index) {
                          final product = order.products[index];
                          return Card(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              color: Colors.white,
                              child: ListTile(
                                dense: true,
                                leading: CircleAvatar(
                                  child: Image(
                                    image: AssetImage('images/mart.jpg'),
                                  ),
                                ),
                                title: Text(product.name),
                                subtitle: Text(
                                    'MRP: $rupeeSymbol${product.markedPrice}   Discount: ${product.discount}%'),
                                trailing:
                                    Text('$rupeeSymbol${product.sellingPrice}'),
                              ),
                            ),
                          );
                        },
                        childCount: order.products.length,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.cyan.shade50,
                  child: ListTile(
                    title: Text('Total'),
                    subtitle: Text(
                        'MRP: $rupeeSymbol${orderDetail["mrp"]}   Discount: 20%'),
                    trailing: Text('$rupeeSymbol${orderDetail["sp"]}'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
