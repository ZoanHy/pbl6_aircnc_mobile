import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pbl6_aircnc/models/booking.dart';
import 'package:pbl6_aircnc/models/property.dart';
import 'package:pbl6_aircnc/models/user.dart';
import 'package:pbl6_aircnc/repositories/auth_repo.dart';
import 'package:pbl6_aircnc/repositories/booking_repo.dart';
import 'package:pbl6_aircnc/repositories/property_repo.dart';
import 'package:pbl6_aircnc/repositories/wishlist_repo.dart';
import 'package:pbl6_aircnc/screens/booking_screen.dart';
import 'package:pbl6_aircnc/screens/result_qr_code_screen.dart';

class TestApiScreen extends StatefulWidget {
  const TestApiScreen({super.key});

  @override
  State<TestApiScreen> createState() => _TestApiScreenState();
}

class _TestApiScreenState extends State<TestApiScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  var codeQr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void filterProperties() async {
    print('helo');
    List<Property> lst = await PropertyRepo.filterListProperties(
        orderBy: 'id', isDescending: true);
    print(lst.length);
    print(lst[1]);
  }

  void filterPropertiesOfHost() async {
    print('helo');
    List<Property> lst =
        await PropertyRepo.filterListPropertiesOfHost(hostId: 6);
    print(lst.length);
  }

  void signIn() async {
    print('signin');
    User? user = await AuthRepo.signIn('zoan12345', '@Bcd1234');
    var token = storage.read(key: 'accessToken').toString();
    print(user);
    // if (user != null) {
    //   setState(() {
    //     userTest = user;
    //   });
    // }
  }

  void SignUp() async {
    print('sign up');
    String result = await AuthRepo.signUp(
        username: 'zoan1',
        fullName: 'huy huy',
        email: 'abcdhuy111@gmail.com',
        password: 'Zo@n1234');

    print(result);
  }

  void getWishLish() async {
    // signIn();
    print('get wish list');
    List<Property> lst = await WishlistRepo.getWishlists();
    print(lst.length);
  }

  void postProperties() async {
    signIn();
    print('hi');
    bool check = await PropertyRepo.postAProperty();
    print(check);
  }

  void addPropertyToWishList() async {
    print('add to wishlsit');
    bool check = await WishlistRepo.addAPropertyToWishlists("25");
    print(check);
  }

  void removePropertyToWishList() async {
    print('remove to wishlsit');
    bool check = await WishlistRepo.removeAPropertyToWishlists("25");
    print(check);
  }

  void getAllBookingOfGuest() async {
    List<Booking> lst = await BookingRepo.getAllBookingOfGuest(guestId: 136);
    Booking booking1 = lst[0];

    print(lst);
  }

  void getDetailProperty() async {
    print('test api');
    Property detail = await PropertyRepo.getPropertyDetail(propertyId: 1);

    print(detail);
  }

  void postABooking() async {
    signIn();
    DateTime startDate = DateTime.now().add(Duration(days: 3));

    DateTime endDate = DateTime.now().add(Duration(days: 5));

    bool check = await BookingRepo.orderBooking(
        1, startDate, endDate, 1, 1, 'co giam gia khong');

    print(check);
  }

  @override
  Widget build(BuildContext context) {
    // filterPropertiesOfHost();
    // postProperties();
    // signIn();
    // print(userTest);
    // getWishLish();
    // SignUp();
    // addPropertyToWishList();
    // removePropertyToWishList();
    // getAllBookingOfGuest();
    // print('build ${codeQr}');
    // postABooking();
    // getDetailProperty();
    // addPropertyToWishList();
    // removePropertyToWishList();

    return Scaffold(
      appBar: AppBar(title: Text('Test api')),
    );
    // getAllBookingOfGuest();
    // return ResultQrCodeScreen(code: codeQr);
    // return BookingScreen(
    //   user: userTest,
    // );
  }
}
