import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_aircnc/blocs/auth_bloc/auth_bloc.dart';
import 'package:pbl6_aircnc/models/user.dart';
import 'package:pbl6_aircnc/screens/home_screen.dart';
import 'package:pbl6_aircnc/screens/profile_screen.dart';
import 'package:pbl6_aircnc/screens/sign_up_screen.dart';
import 'package:pbl6_aircnc/screens/tabs_screen.dart';
import 'package:icons_plus/icons_plus.dart';

class SignInScreen extends StatefulWidget {
  static const id = 'sign_in_screen';
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;

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
        TextEditingController(text: 'zoan12345');
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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            'Login failed',
            style: TextStyle(color: Colors.red),
          )));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AuthLoadingState:
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case AunthenticateUninitializedState:
            return Scaffold(
              body: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 10.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formSignInKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 150,
                                width: 150,
                                child: Image(
                                  image: AssetImage(
                                      "assets/images/logo-aircnc.png"),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              Text(
                                'Welcome AirCnC',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF416FDF),
                                ),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              TextFormField(
                                controller: usernameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  label: const Text('Email Or Username'),
                                  hintText: 'Enter Email or Username',
                                  hintStyle: const TextStyle(
                                    color: Colors.black26,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors
                                          .black12, // Default border color
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors
                                          .black12, // Default border color
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                obscuringCharacter: '*',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Password';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  label: const Text('Password'),
                                  hintText: 'Enter Password',
                                  hintStyle: const TextStyle(
                                    color: Colors.black26,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors
                                          .black12, // Default border color
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors
                                          .black12, // Default border color
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: rememberPassword,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            rememberPassword = value!;
                                          });
                                        },
                                        activeColor: Color(0xFF416FDF),
                                      ),
                                      const Text(
                                        'Remember me',
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      'Forget password?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF416FDF),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formSignInKey.currentState!
                                            .validate() &&
                                        rememberPassword) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Processing Data'),
                                        ),
                                      );
                                    } else if (!rememberPassword) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Please agree to the processing of personal data')),
                                      );
                                    }
                                  },
                                  child: TextButton(
                                    onPressed: () {
                                      String username = usernameController.text;
                                      String password = passwordController.text;

                                      authBloc.add(
                                        AuthSignIn(
                                          username,
                                          password,
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Sign in",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Divider(
                                      thickness: 0.7,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      'Sign up with',
                                      style: TextStyle(
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      thickness: 0.7,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ContinueWith(
                                      'assets/images/social_media/facebook.png'),
                                  ContinueWith(
                                      'assets/images/social_media/google.png'),
                                  ContinueWith(
                                      'assets/images/social_media/twitter.png'),
                                ],
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              // don't have an account
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account? ',
                                    style: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (e) => SignUpScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF416FDF),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
      padding: EdgeInsets.all(10),
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
