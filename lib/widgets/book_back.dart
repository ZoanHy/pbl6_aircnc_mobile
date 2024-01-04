import 'package:flutter/material.dart';
import 'package:pbl6_aircnc/models/host.dart';
import 'constants.dart';
import 'landlord_info.dart';

class BookBack extends StatelessWidget {
  const BookBack(
    this.hostInfoDetail, {
    super.key,
  });

  final Host hostInfoDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 40),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(Constants.bookBorderRadius),
          bottomRight: Radius.circular(Constants.bookBorderRadius),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(-6, 0),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(6, 0),
          ),
        ],
      ),
      child: LandlordInfo(hostInfoDetail),
    );
  }
}
