// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pbl6_aircnc/models/user.dart';

class ProfileScreen extends StatelessWidget {
  User user;
  ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white, // Set background color to white
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            SizedBox(height: 30),
            Text(
              'Name: ${user.fullName}',
              style: TextStyle(
                color: Colors.blue, // Set text color to blue
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Email: ${user.email}',
              style: TextStyle(
                color: Colors.blue, // Set text color to blue
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
