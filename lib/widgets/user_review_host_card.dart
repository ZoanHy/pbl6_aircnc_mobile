// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pbl6_aircnc/blocs/user_bloc/user_bloc.dart';
import 'package:pbl6_aircnc/models/review_host.dart';
import 'package:pbl6_aircnc/models/user.dart';
import 'package:readmore/readmore.dart';

import 'package:pbl6_aircnc/models/review.dart';
import 'package:pbl6_aircnc/widgets/rating_bar_indicator_item.dart';

class UserReviewHostCard extends StatefulWidget {
  final ReviewHost reviewHost;

  const UserReviewHostCard({
    Key? key,
    required this.reviewHost,
  }) : super(key: key);

  @override
  State<UserReviewHostCard> createState() => _UserReviewHostCardState();
}

class _UserReviewHostCardState extends State<UserReviewHostCard> {
  String formatDateFunc(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: widget.reviewHost.reviewerAvatarUrl != null
                        ? CachedNetworkImage(
                            imageUrl: widget.reviewHost.reviewerAvatarUrl,
                            fit: BoxFit.cover,
                            errorWidget: (context, error, stackTrace) {
                              return Image(
                                image: AssetImage(
                                    "assets/images/image_not_found.jpg"),
                                fit: BoxFit.scaleDown,
                              );
                            },
                          )
                        : Text(
                            '${widget.reviewHost.reviewerName.toUpperCase()}',
                            style: TextStyle(fontSize: 20),
                          ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.reviewHost.reviewerName,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                )
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
          ],
        ),
        SizedBox(
          height: 15,
        ),

        // review
        Row(
          children: [
            RatingBarIndicatorItem(rating: 4),
            SizedBox(
              width: 10,
            ),
            Text(
              '${formatDateFunc(widget.reviewHost.reviewTime)}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        ReadMoreText(
          '${widget.reviewHost.content}',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: ' show less',
          trimCollapsedText: ' show more',
          moreStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
          lessStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
