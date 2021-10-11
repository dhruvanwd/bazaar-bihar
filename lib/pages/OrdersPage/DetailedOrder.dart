import 'package:bazaar_bihar/GetxControllers/OrderController.dart';
import 'package:bazaar_bihar/shared/Utils/orderStatuses.dart';
import 'package:bazaar_bihar/shared/Utils/utils.dart';
import 'package:bazaar_bihar/shared/components/RateNdReview.dart';
import 'package:bazaar_bihar/shared/components/StrechedPrimaryButton.dart';
import 'package:bazaar_bihar/shared/orderComponents/DenseProductCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/orderComponents/orderUserNameDateCount.dart';
import '../../shared/orderComponents/orderPriceSummary.dart';
import '../../shared/models/OrderModel.dart';

class DetailedOrder extends StatelessWidget {
  final OrderModel orderDetail;
  DetailedOrder(this.orderDetail);
  /**
   * when user rates order . he will get points.
   * which he can use to purchase any product.
   * 
   * 
   * There should be option to select home delivery under certain circumstances
   * like price range or user distance from shop etc
   */

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (_orderCtrl) => Scaffold(
        appBar: AppBar(
          title: Text("Order Details"),
        ),
        // TODO: only allow users to rate when order is completed
        persistentFooterButtons: orderDetail.isRated
            ? null
            : [
                if (orderDetail.status != OrderStatus.REJECTED.name &&
                    orderDetail.status != OrderStatus.INITIATED.name)
                  StrechedPrimaryButton(() {
                    Get.dialog(
                      RateReviewDialog(
                        (double rating, String review) async {
                          await _orderCtrl.rateNdReviewOrder(
                            orderDetail,
                            {
                              "rating": rating,
                              "review": review,
                            },
                          );
                          Get.back();
                        },
                      ),
                    );
                  }, "Rate this order")
              ],
        body: Container(
          height: Get.mediaQuery.size.height,
          decoration: BoxDecoration(gradient: lightGradient),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 8),
                        child: orderUserNameDateCount(orderDetail),
                      ),
                      orderPriceSummary(orderDetail),
                      if (orderDetail.isRated)
                        Container(
                          padding: EdgeInsets.only(left: 16, bottom: 8),
                          child: Container(
                            width: 180,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "You rated: ",
                                  style: TextStyle(
                                      color: Colors.lightBlue.shade50),
                                ),
                                Text(
                                  "${orderDetail.rating} out of 5",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (orderDetail.isRated)
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text(
                                  "Review",
                                  style:
                                      Get.theme.textTheme.subtitle2?.copyWith(
                                    color: Colors.lightBlue,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(orderDetail.review!),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      ...orderDetail.products
                          .map((product) => DenseProductCard(
                                product,
                                isOrdered: true,
                              ))
                          .toList(),
                      Padding(padding: EdgeInsets.symmetric(vertical: 16))
                    ],
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
