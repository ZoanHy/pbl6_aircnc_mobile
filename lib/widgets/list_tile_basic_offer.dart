import 'package:flutter/material.dart';

class ListTileBasicOffer extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subCountInfo;
  Color? color;

  ListTileBasicOffer({
    Key? key,
    required this.icon,
    required this.title,
    required this.subCountInfo,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
        color: color != null ? color : Colors.blue,
      ),
      title: Text(title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      subtitle: Text(subCountInfo,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}