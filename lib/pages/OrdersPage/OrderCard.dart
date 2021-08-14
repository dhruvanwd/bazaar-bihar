import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  OrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            color: Get.theme.primaryColor,
            child: Column(
              children: [
                Center(
                  child: Image.asset('images/mart.jpg', fit: BoxFit.cover),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 2, color: Colors.grey.shade400),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      'Saraswati general store',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      "5 Oct 2021",
                      style: TextStyle(
                        color: Colors.blueGrey.shade100,
                      ),
                    ),
                    trailing: Text(
                      '\$ 200',
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
            padding: EdgeInsets.all(8),
            color: Colors.cyan.shade100,
            child: Column(
              children: [
                Expanded(
                  child: ListView.custom(
                    childrenDelegate: SliverChildBuilderDelegate(
                      (_, index) {
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
                              title: Text('Sugar'),
                              subtitle: Text('MP: \$ 200   Discount: 20%'),
                              trailing: Text('\$ 180'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Total'),
                  subtitle: Text('MP: \$ 2000   Discount: 20%'),
                  trailing: Text('\$ 1800'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
