import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pbl6_aircnc/blocs/user_bloc/user_bloc.dart';


class EditProfileScreen extends StatefulWidget {
  int userId;

  EditProfileScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool notIsEdit = true;

  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final UserBloc userBloc = UserBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userBloc.add(LoadUserDetailEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: userBloc,
        builder: (context, state) {
          if (state is LoadUserDetailState) {
            fullnameController.text = state.userDetail.fullName;
            emailController.text = state.userDetail.email;
            phoneController.text = state.userDetail.phoneNumber ?? "";
            addressController.text = state.userDetail.address ?? "";
            descriptionController.text = state.userDetail.introduction ?? "";

            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: state.userDetail.avatarUrl != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        state.userDetail.avatarUrl.toString(),
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
                                    '${state.userDetail.fullName[0].toUpperCase()}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  notIsEdit = !notIsEdit;
                                });
                              },
                              child: Icon(
                                LineAwesome.pencil_alt_solid,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                          controller: fullnameController,
                          readOnly: notIsEdit,
                          decoration: InputDecoration(
                              filled: notIsEdit,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              prefixIconColor: Colors.black,
                              floatingLabelStyle:
                                  TextStyle(color: Colors.black),
                              label: Text('Fullname'),
                              prefixIcon: Icon(LineAwesome.user_alt_solid),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          readOnly: notIsEdit,
                          decoration: InputDecoration(
                              filled: notIsEdit,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              prefixIconColor: Colors.black,
                              floatingLabelStyle:
                                  TextStyle(color: Colors.black),
                              label: Text('Email'),
                              prefixIcon: Icon(LineAwesome.envelope_solid),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: phoneController,
                          readOnly: notIsEdit,
                          decoration: InputDecoration(
                              filled: notIsEdit,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              prefixIconColor: Colors.black,
                              floatingLabelStyle:
                                  TextStyle(color: Colors.black),
                              label: Text('Phone'),
                              prefixIcon: Icon(LineAwesome.phone_alt_solid),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: descriptionController,
                          readOnly: notIsEdit,
                          minLines: 3,
                          maxLines: 5,
                          decoration: InputDecoration(
                              filled: notIsEdit,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              prefixIconColor: Colors.black,
                              floatingLabelStyle:
                                  TextStyle(color: Colors.black),
                              label: Text('Description'),
                              prefixIcon: Icon(LineAwesome.sticky_note),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        !notIsEdit
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        notIsEdit = !notIsEdit;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(' Save ',
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green)),
                                  )
                                ],
                              )
                            : SizedBox.shrink(),
                      ],
                    ))
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
