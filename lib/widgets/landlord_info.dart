import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbl6_aircnc/models/host.dart';

class LandlordInfo extends StatelessWidget {
  const LandlordInfo(
    this.hostInfoDetail, {
    super.key,
  });

  final Host hostInfoDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hostInfoDetail.numberOfReviews.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Text(
          'Reviews',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Divider(thickness: 0.8),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${hostInfoDetail.rating.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 2),
            const Icon(Icons.star_rounded, size: 20),
          ],
        ),
        const Text(
          'Rating',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Divider(thickness: 0.8),
        const SizedBox(height: 8),
        Text(
          '${DateFormat('dd/MM/yyyy').format(hostInfoDetail.joinedAt)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Text(
          'Joined at',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
