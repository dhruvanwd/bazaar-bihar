import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  OrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL, // default
        front: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            color: Colors.blue.shade200,
            child: Column(
              children: [
                Center(
                  child: Image.asset('images/mart.jpg', fit: BoxFit.cover),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 2, color: Colors.purple),
                    ),
                  ),
                  child: ListTile(
                    title: Text('Saraswati general store'),
                    subtitle: Text("5 Oct 2021"),
                    trailing: Text('\$ 200'),
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
                                  image: NetworkImage('images/mart.jpg'),
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
