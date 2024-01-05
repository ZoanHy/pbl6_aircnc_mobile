import 'package:flutter/material.dart';
import 'package:pbl6_aircnc/models/host.dart';
import 'constants.dart';
import 'avatar.dart';

class BookCoverBack extends StatelessWidget {
  const BookCoverBack(
    this.hostInfoDetail, {
    super.key,
  });

  final Host hostInfoDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
        left: 20,
        right: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Constants.bookBorderRadius),
          bottomLeft: Radius.circular(Constants.bookBorderRadius),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(-6, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              Avatar(
                imageUrl:
                    hostInfoDetail.avatarUrl ?? "assets/images/minhhuy.jpg",
                hasBadge: true,
              ),
              const SizedBox(height: 10),
              Text(
                hostInfoDetail.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
