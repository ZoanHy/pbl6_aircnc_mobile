import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_aircnc/blocs/auth_bloc/auth_bloc.dart';
import 'package:pbl6_aircnc/models/user.dart';
import 'package:pbl6_aircnc/screens/home_screen.dart';
import 'package:pbl6_aircnc/screens/profile_screen.dart';
import 'package:pbl6_aircnc/screens/sign_up_screen.dart';
import 'package:pbl6_aircnc/screens/tabs_screen.dart';

class SignInScreen extends StatefulWidget {
  static const id = 'sign_in_screen';
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  BoxDecoration customDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 2),
          color: Colors.grey,
          blurRadius: 5,
        )
      ],
    );
  }

  final AuthBloc authBloc = AuthBloc();

  @override
  void initState() {
    // TODO: implement initState
    authBloc.add(AuthAppStartedEvent());
    super.initState();
    print('init sign in');
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController =
        TextEditingController(text: 'zoan123');
    final TextEditingController passwordController =
        TextEditingController(text: '@Bcd1234');

    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      buildWhen: (previous, current) => current is! AuthSignInActionState,
      listenWhen: (previous, current) => current is AuthSignInActionState,
      listener: (context, state) {
        if (state is AuthSignInActionState) {
          User user = state.user;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TabsScreen(
                  user: user,
                ),
              ));
        } else if (state is AuthErrorState) {
          print('error');
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AunthenticateUninitializedState:
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                maintainBottomViewPadding: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 130,
                          width: 130,
                          child: Image(
                            image: AssetImage("assets/images/logo-aircnc.png"),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: customDecoration(),
                          child: TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              hintText: "Email or Username",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.mail_outline,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: customDecoration(),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Password",
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.blue,
                                )),
                          ),
                        ),
                        Visibility(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Forgot password ?",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 14),
                                )),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {},
                          splashColor: Colors.white,
                          hoverColor: Colors.blue,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  color: Colors.grey,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Center(
                                child: TextButton(
                                    onPressed: () {
                                      print('hello sign in');
                                      var username = usernameController.text;
                                      var password = passwordController.text;
                                      authBloc
                                          .add(AuthSignIn(username, password));
                                    },
                                    child: Text(
                                      "Continue",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ))),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('sign out');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ));
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: InkWell(
                                child: RichText(
                                  text: TextSpan(
                                      text: "New User ?",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      children: [
                                        TextSpan(
                                          text: " Create an account",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Or continue with ",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ContinueWith(
                                "assets/images/social_media/google.png"),
                            ContinueWith(
                                "assets/images/social_media/phone.png"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          default:
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                maintainBottomViewPadding: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 130,
                          width: 130,
                          child: Image(
                            image: AssetImage("assets/images/logo-aircnc.png"),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: customDecoration(),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Email or Username",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.mail_outline,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: customDecoration(),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Password",
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.blue,
                                )),
                          ),
                        ),
                        Visibility(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Forgot password ?",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 14),
                                )),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {},
                          splashColor: Colors.white,
                          hoverColor: Colors.blue,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  color: Colors.grey,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Center(
                                child: TextButton(
                                    onPressed: () {
                                      print('hello sign in return');
                                      // Navigator.push(context, route)
                                    },
                                    child: Text(
                                      "Continue",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ))),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: InkWell(
                                child: RichText(
                                  text: TextSpan(
                                      text: "New User ?",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      children: [
                                        TextSpan(
                                          text: " Create an account",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Or continue with ",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ContinueWith(
                                "assets/images/social_media/google.png"),
                            ContinueWith(
                                "assets/images/social_media/phone.png"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }

  Container ContinueWith(String image) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(offset: Offset(0, 3), color: Colors.grey, blurRadius: 5)
          ]),
      child: Image.asset(
        image,
      ),
    );
  }
}
