import 'package:easy_rich_text/easy_rich_text.dart';

import '../Utils/extensions.dart';
import '../models/OrderModel.dart';
import 'package:flutter/material.dart';

orderUserNameDateCount(OrderModel orderDetail) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: EasyRichText(
              "${orderDetail.userName.capitalizeFirstofEach} has placed order.",
              patternList: [
                EasyRichTextPattern(
                  targetString: orderDetail.userName.capitalizeFirstofEach,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 4),
            child: EasyRichText(
              orderDetail.createdAt,
              patternList: [
                EasyRichTextPattern(
                  targetString: orderDetail.createdAt,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: EasyRichText(
          "(${orderDetail.products.length}) Items",
          patternList: [
            EasyRichTextPattern(
              targetString: "(${orderDetail.products.length})",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            )
          ],
        ),
      ),
    ],
  );
}
