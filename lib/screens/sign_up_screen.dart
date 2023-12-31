import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_aircnc/blocs/auth_bloc/auth_bloc.dart';
import 'package:pbl6_aircnc/screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignupKey = GlobalKey<FormState>();
  bool agreePersonalData = true;
  final AuthBloc authBloc = AuthBloc();

  bool _isObscure = true;
  bool _isObscureConfirm = true;

  TextEditingController fullnameController =
      TextEditingController(text: 'minh huy');
  TextEditingController emailController =
      TextEditingController(text: 'minhhuy1@gmail.com');
  TextEditingController usernameController =
      TextEditingController(text: 'zoanzoan1');
  TextEditingController passwordController =
      TextEditingController(text: '@Bcd1234');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '@Bcd1234');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthSignUpSuccessState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Sign up success')));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (e) => SignInScreen(),
              ),
            );
          } else if (state is AuthSignUpFailedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Sign up failed')));
          }
        },
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: SingleChildScrollView(
                  // get started form
                  child: Form(
                    key: _formSignupKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // get started text
                        Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF416FDF),
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        // full name
                        TextFormField(
                          controller: fullnameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Full name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Full Name'),
                            hintText: 'Enter Full Name',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        // email
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Email'),
                            hintText: 'Enter Email',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        // user name
                        TextFormField(
                          controller: usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: const Text('Username'),
                            hintText: 'Enter Username',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        // password
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
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        // password
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: _isObscureConfirm,
                          obscuringCharacter: '*',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            if (value != passwordController.text) {
                              return 'Please enter same Password';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_isObscureConfirm
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscureConfirm = !_isObscureConfirm;
                                });
                              },
                            ),
                            label: const Text('Confirm Password'),
                            hintText: 'Enter Confirm Password',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12, // Default border color
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        // i agree to the processing
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: agreePersonalData,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      agreePersonalData = value!;
                                    });
                                  },
                                  activeColor: Color(0xFF416FDF),
                                ),
                                const Text(
                                  'I agree to \nthe processing',
                                  style: TextStyle(
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Personal data',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF416FDF),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        // signup button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formSignupKey.currentState!.validate() &&
                                    agreePersonalData) {
                                  print('hi');
                                  authBloc.add(AuthSignUp(
                                      username: usernameController.text,
                                      email: emailController.text,
                                      fullName: fullnameController.text,
                                      password: passwordController.text));
                                } else if (!agreePersonalData) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please agree to the processing of personal data')),
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Sign up'),
                              )),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        // sign up divider
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
                          height: 30.0,
                        ),
                        // sign up social media logo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        // already have an account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (e) => SignInScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign in',
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
