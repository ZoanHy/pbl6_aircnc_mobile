// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pbl6_aircnc/blocs/auth_bloc/auth_bloc.dart';

import 'package:pbl6_aircnc/models/user.dart';
import 'package:pbl6_aircnc/screens/qr_scanner_screen.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  User user;
  ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: SingleChildScrollView(
            child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: widget.user.avatarUrl != null
                        ? CachedNetworkImage(
                            imageUrl: widget.user.avatarUrl,
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
                            '${widget.user.fullName[0].toUpperCase()}',
                            style: TextStyle(fontSize: 20),
                          ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${widget.user.fullName}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '${widget.user.email}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellowAccent.shade400,
                        side: BorderSide.none,
                        shape: StadiumBorder()),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),

                //MENU
                ProfileMenuItem(
                  title: 'Settings',
                  icon: LineAwesome.cog_solid,
                  onPress: () {},
                ),
                widget.user.isHost
                    ? ProfileMenuItem(
                        title: 'Scan Qr Code',
                        icon: LineAwesome.qrcode_solid,
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QrScannerScreen(),
                              ));
                        },
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
    this.user,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blueAccent.withOpacity(0.1)),
        child: Icon(
          icon,
          color: Colors.blueAccent,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold).apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1)),
              child: Icon(
                LineAwesome.angle_right_solid,
                size: 18,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
