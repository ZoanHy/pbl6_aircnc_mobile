// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pbl6_aircnc/models/user.dart';
import 'package:pbl6_aircnc/screens/sign_in_screen.dart';
import 'package:pbl6_aircnc/screens/tabs_screen.dart';

class AppRouter {
  final User user;
  AppRouter({
    required this.user,
  });

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SignInScreen.id:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case TabsScreen.id:
        return MaterialPageRoute(
            builder: (context) => TabsScreen(
                  user: user,
                ));
      default:
        return null;
    }
  }
}
