import './StrechedPrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateReviewDialog extends StatefulWidget {
  final onCompleteRating;
  const RateReviewDialog(this.onCompleteRating);

  @override
  _RateReviewDialogState createState() => _RateReviewDialogState();
}

class _RateReviewDialogState extends State<RateReviewDialog> {
  final TextEditingController _editingController = new TextEditingController();
  double _rating = 0.0;

  onChangeRating(dynamic rating) {
    print(rating);
    _rating = rating;
  }

  onCompleteRating() {
    widget.onCompleteRating(_rating, _editingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Text(
                    "Rate this order.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: onChangeRating,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                  child: TextFormField(
                    controller: _editingController,
                    decoration: InputDecoration(
                      labelText: "Review this order",
                    ),
                  ),
                ),
                StrechedPrimaryButton(onCompleteRating, "Complete Rating")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
