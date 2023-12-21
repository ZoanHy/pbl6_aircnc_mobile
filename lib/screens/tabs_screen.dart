// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pbl6_aircnc/models/user.dart';
import 'package:pbl6_aircnc/screens/booking_screen.dart';
import 'package:pbl6_aircnc/screens/home_screen.dart';
import 'package:pbl6_aircnc/screens/profile_screen.dart';
import 'package:pbl6_aircnc/screens/wishlist_screen.dart';

// ignore: must_be_immutable
class TabsScreen extends StatefulWidget {
  static const id = 'tabs_screen';

  final User user;

  TabsScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late User user;
  late List<Map<String, dynamic>> _pageDetails;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    _pageDetails = [
      {'pageName': HomeScreen(), 'title': 'Home Screen'},
      {'pageName': WishlistScreen(), 'title': 'Wishlist Screen'},
      {
        'pageName': BookingScreen(
          user: user,
        ),
        'title': 'Booking Screen'
      },
      {
        'pageName': ProfileScreen(
          user: user,
        ),
        'title': 'Profile Screen'
      }
    ];
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.blue,
        ),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
          color: Colors.blue,
        ),
        label: 'Favorite'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.bookmark_outline,
          color: Colors.blue,
        ),
        label: 'Booking'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Colors.blue,
        ),
        label: 'Profile')
  ];

  var _seletedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.user);

    // return Scaffold(
    //   body: _pageDetails[_seletedPageIndex]['pageName'],
    //   bottomNavigationBar: BottomNavigationBar(
    //       showSelectedLabels: false,
    //       currentIndex: _seletedPageIndex,
    //       onTap: (index) {
    //         setState(() {
    //           _seletedPageIndex = index;
    //         });
    //       },
    //       items: _bottomNavigationBarItems),
    // );

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.blue,
        items: _bottomNavigationBarItems,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) => CupertinoPageScaffold(child: HomeScreen()),
            );

          case 1:
            return CupertinoTabView(
              builder: (context) =>
                  CupertinoPageScaffold(child: WishlistScreen()),
            );

          case 2:
            return CupertinoTabView(
              builder: (context) => CupertinoPageScaffold(
                  child: BookingScreen(
                user: user,
              )),
            );

          case 3:
            return CupertinoTabView(
              builder: (context) => CupertinoPageScaffold(
                  child: ProfileScreen(
                user: user,
              )),
            );
        }
        return Container();
      },
    );
  }
}
