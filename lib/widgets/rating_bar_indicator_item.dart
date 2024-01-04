import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:icons_plus/icons_plus.dart';

class RatingBarIndicatorItem extends StatelessWidget {
  const RatingBarIndicatorItem({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20,
      unratedColor: Colors.grey.shade300,
      itemBuilder: (context, index) => Icon(
        Iconsax.magic_star,
        color: Colors.blue,
      ),
    );
  }
}
