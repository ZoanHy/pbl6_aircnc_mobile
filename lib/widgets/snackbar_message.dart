// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SnackBarMessage extends StatelessWidget {
  final String message;
  final bool status;

  const SnackBarMessage({
    Key? key,
    required this.message,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return status
        ? SnackBar(
            content: Text(message),
            backgroundColor: Colors.green,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          )
        : SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          );
  }
}
