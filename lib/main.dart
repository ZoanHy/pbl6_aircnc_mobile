import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_aircnc/blocs/auth_bloc/auth_bloc.dart';
import 'package:pbl6_aircnc/blocs/booking_bloc/booking_bloc.dart';
import 'package:pbl6_aircnc/blocs/property_bloc/property_bloc.dart';
import 'package:pbl6_aircnc/blocs/user_bloc/user_bloc.dart';
import 'package:pbl6_aircnc/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:pbl6_aircnc/screens/booking_detail_screen.dart';
import 'package:pbl6_aircnc/screens/booking_screen.dart';
import 'package:pbl6_aircnc/screens/edit_profile_screen.dart';
import 'package:pbl6_aircnc/screens/home_screen.dart';
import 'package:pbl6_aircnc/screens/property_detail_screen.dart';
import 'package:pbl6_aircnc/screens/qr_scanner_screen.dart';
import 'package:pbl6_aircnc/screens/result_qr_code_screen.dart';
import 'package:pbl6_aircnc/screens/sign_in_screen.dart';
import 'package:pbl6_aircnc/screens/tabs_screen.dart';
import 'package:pbl6_aircnc/screens/test_api_screen.dart';
import 'package:pbl6_aircnc/screens/wishlist_screen.dart';

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
        BlocProvider(
          create: (context) => UserBloc(),
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
        // home: DemoNumberPaginiation(),
        // home: WishlistScreen(),
        // home: PropertyDetailScreen(),
        // home: GoogleMapScreen(),
        // home: BookingDetailScreen(),
        // home: MyAppVNPay(),
        // home: EditProfileScreen(),

        // home: Scaffold(
        //     body: ElevatedButton(
        //   child: Text('abc'),
        //   onPressed: () async {
        //     var url =
        //         "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_Amount=2103700000&vnp_BankCode=VNBANK&vnp_Command=pay&vnp_CreateDate=20240103120943&vnp_CurrCode=VND&vnp_IpAddr=%3A%3Affff%3A172.17.0.21&vnp_Locale=vn&vnp_OrderInfo=%23638398553830686239+%7C+Thanh+toan+dat+phong+%23580&vnp_OrderType=other&vnp_ReturnUrl=https%3A%2F%2Faircnc.whitemage.tech%2Fbooking-checked&vnp_TmnCode=M76I10UL&vnp_TxnRef=638398553830686239&vnp_Version=2.1.0&vnp_SecureHash=18e3293ddcd099dc99fb7b147e034b76cd62fede2ad456b47881d3e1643b9adb3ce2e75baef46c5aec1d135b345a90b0667a662934013225dc7221a984e53cb2";
        //     if (await canLaunchUrlString(url)) {
        //       launchUrlString(url, mode: LaunchMode.inAppWebView);
        //     }
        // },
        // )),
      ),
    );
  }
}
