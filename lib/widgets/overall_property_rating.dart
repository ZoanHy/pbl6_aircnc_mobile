// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pbl6_aircnc/models/review.dart';
import 'package:pbl6_aircnc/widgets/rating_bar_indicator_item.dart';
import 'package:pbl6_aircnc/widgets/rating_process_indicator.dart';

class OverallPropertyRating extends StatelessWidget {
  List<Review> lstReview;

  OverallPropertyRating({
    Key? key,
    required this.lstReview,
  }) : super(key: key);

  Map<String, dynamic> getAllInfoAverageForRating(List<Review> lstReview) {
    double ratingAverage = 0;
    List<double> lstCountNumberOfValueRating = [0, 0, 0, 0, 0];
    int countNumberOfVoting = lstReview.length;

    for (Review review in lstReview) {
      ratingAverage += review.value / countNumberOfVoting;
      lstCountNumberOfValueRating[review.value - 1] += 1 / countNumberOfVoting;
    }

    Map<String, dynamic> result = {
      'ratingAverage': ratingAverage,
      'lstCountNumberOfValueRating': lstCountNumberOfValueRating,
    };

    print(result['ratingAverage']);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final ratingAverage =
        getAllInfoAverageForRating(lstReview)['ratingAverage'];
    final lstCountNumberOfValueRating =
        getAllInfoAverageForRating(lstReview)['lstCountNumberOfValueRating'];
    ;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                '${(ratingAverage as double).toStringAsFixed(1)}',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: lstCountNumberOfValueRating.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return RatingProcessIndicator(
                        text: '${lstCountNumberOfValueRating.length - index}',
                        value: lstCountNumberOfValueRating[
                            lstCountNumberOfValueRating.length - index - 1],
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
        RatingBarIndicatorItem(
          rating: ratingAverage,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '${lstCountNumberOfValueRating.length} reviews',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
