// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pbl6_aircnc/blocs/review_bloc/review_bloc.dart';

import 'package:pbl6_aircnc/models/review.dart';
import 'package:pbl6_aircnc/models/test/model_test.dart';
import 'package:pbl6_aircnc/widgets/overall_property_rating.dart';
import 'package:pbl6_aircnc/widgets/rating_bar_indicator_item.dart';
import 'package:pbl6_aircnc/widgets/rating_process_indicator.dart';
import 'package:pbl6_aircnc/widgets/user_review_card.dart';

class ReviewScreen extends StatefulWidget {
  final int propertyId;
  const ReviewScreen({
    Key? key,
    required this.propertyId,
  }) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final ReviewBloc reviewBloc = ReviewBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reviewBloc.add(LoadReviewEvent(propertyId: widget.propertyId));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: BlocBuilder<ReviewBloc, ReviewState>(
        bloc: reviewBloc,
        builder: (context, state) {
          if (state is LoadReviewState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // overall product ratings
                    Text(
                      'Ratings and reviews are verified and are from people who use the same type of device that you use',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    OverallPropertyRating(
                      lstReview: state.lstReview,
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.lstReview.length,
                      itemBuilder: (context, index) {
                        return UserReviewCard(
                          review: state.lstReview[index],
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
