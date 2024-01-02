import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
  bool _isObscure = true;

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

    firebase_auth.FirebaseAuth _firebaseAuth =
        firebase_auth.FirebaseAuth.instance;

    return BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is AunthenticateInitializedState) {
            User user = state.user;
            print(user);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TabsScreen(
                    user: user,
                  ),
                ));
            context.loaderOverlay.hide();
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              'Login failed',
              style: TextStyle(color: Colors.red),
            )));
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case AunthenticateUninitializedState:
              print('un init');

              return LoaderOverlay(
                child: Scaffold(
                  body: Column(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 10.0),
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
                                    obscureText: _isObscure,
                                    obscuringCharacter: '*',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Password';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(_isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        },
                                      ),
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
                                            Scaffold(
                                              body: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            );

                                            Future.delayed(
                                                Duration(seconds: 2));
                                            context.loaderOverlay.show();
                                            String username =
                                                usernameController.text;
                                            String password =
                                                passwordController.text;

                                            authBloc.add(
                                              AuthSignIn(
                                                username,
                                                password,
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text('Sign in'),
                                        )),
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
                                      GestureDetector(
                                        onTap: () {
                                          _signInWithGoogle();
                                        },
                                        child: ContinueWith(
                                            'assets/images/social_media/google.png'),
                                      ),
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
                                          Navigator.pushReplacement(
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
                ),
              );
            default:
              return Container();
          }
        });
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

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final firebase_auth.AuthCredential credential =
            firebase_auth.GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await firebase_auth.FirebaseAuth.instance
            .signInWithCredential(credential);
        print('ok GG');
      }
    } catch (e) {
      showToast(message: "some error occured $e");
      print(e.toString());
    }
  }

  void showToast({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
