import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_aircnc/blocs/auth_bloc/auth_bloc.dart';
import 'package:pbl6_aircnc/blocs/booking_bloc/booking_bloc.dart';
import 'package:pbl6_aircnc/blocs/property_bloc/property_bloc.dart';
import 'package:pbl6_aircnc/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:pbl6_aircnc/screens/booking_screen.dart';
import 'package:pbl6_aircnc/screens/home_screen.dart';
import 'package:pbl6_aircnc/screens/qr_scanner_screen.dart';
import 'package:pbl6_aircnc/screens/result_qr_code_screen.dart';
import 'package:pbl6_aircnc/screens/sign_in_screen.dart';
import 'package:pbl6_aircnc/screens/tabs_screen.dart';
import 'package:pbl6_aircnc/screens/test_api_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => PropertyBloc(),
        ),
        BlocProvider(
          create: (context) => WishlistBloc(),
        ),
        BlocProvider(
          create: (context) => BookingBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue, useMaterial3: false),
        debugShowCheckedModeBanner: false,
        // home: HomeScreen(),
        // home: TabsScreen(),
        // home: QrScannerScreen(),
        // home: ScannQrCodeScreen(),
        // home: BookingScreen()
        home: SignInScreen(),
        // home: TestApiScreen(),
        // home: ExampleApp(),
        // home: ProfileScreen1(),
      ),
    );
  }
}
