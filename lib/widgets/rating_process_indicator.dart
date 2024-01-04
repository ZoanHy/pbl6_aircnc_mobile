
import 'package:flutter/material.dart';

class RatingProcessIndicator extends StatelessWidget {
  const RatingProcessIndicator({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
            flex: 11,
            child: SizedBox(
              width: width * 0.8,
              child: LinearProgressIndicator(
                value: value,
                minHeight: 10,
                backgroundColor: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(27),
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ))
      ],
    );
  }
}