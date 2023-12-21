// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_aircnc/blocs/auth_bloc/auth_bloc.dart';

import 'package:pbl6_aircnc/models/user.dart';
import 'package:pbl6_aircnc/screens/qr_scanner_screen.dart';

class ProfileScreen extends StatelessWidget {
  User user;


  ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: BlocListener<AuthBloc, AuthState>(
      
        listener: (context, state) {
          // TODO: implement listener
        },
        child: Container(
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
                child: CachedNetworkImage(
                  imageUrl: user.avatarUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, stackTrace) {
                    return Image(
                      image: AssetImage("assets/images/image_not_found.jpg"),
                      fit: BoxFit.scaleDown,
                    );
                  },
                ),
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
              user.isHost
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QrScannerScreen(),
                            ));
                      },
                      child: Text('Scan'),
                    )
                  : SizedBox.shrink(),
              ElevatedButton(onPressed: () {}, child: Text('Sign out'))
            ],
          ),
        ),
      ),
    );
  }
}
