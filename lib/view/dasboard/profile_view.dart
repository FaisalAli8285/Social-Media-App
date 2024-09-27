import 'dart:io';

import 'package:finallysocialapp/res/colors.dart';
import 'package:finallysocialapp/services/session_manager.dart';
import 'package:finallysocialapp/viewmodel/profile/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("User");
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
      create: (_) => ProfileController(),
      child: Consumer<ProfileController>(builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: height * 0.02),
          child: SafeArea(
              child: StreamBuilder(
                  stream:
                      ref.child(SessionController().userId.toString()).onValue,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.040,
                          ),
                          Stack(alignment: Alignment.bottomCenter, children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Center(
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.primaryTextTextColor,
                                    ),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: provider.image == null
                                          ? map["profile"].toString() == ''
                                              ? Icon(
                                                  Icons.person,
                                                  size: 35,
                                                )
                                              : Image(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      map['profile']
                                                          .toString()),
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  },
                                                  errorBuilder: (context,
                                                      Object, StackTrace) {
                                                    return Container(
                                                      child: Icon(
                                                        Icons.error_outline,
                                                        color: AppColors
                                                            .alertColor,
                                                      ),
                                                    );
                                                  },
                                                )
                                          //Creates a widget that displays an [ImageStream] obtained from a [File].
                                          : Image.file(
                                              fit: BoxFit.cover,
                                              File(provider.image!.path)
                                                  .absolute)),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                provider.pickImage(context);
                              },
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: AppColors.primaryIconColor,
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ]),
                          GestureDetector(
                            onTap: () {
                              provider.showUserNameDialogAlert(
                                  context, map["name"]);
                            },
                            child: ResusableRow(
                                iconData: Icons.person,
                                title: "name",
                                value: map["name"]),
                          ),
                          ResusableRow(
                              iconData: Icons.email,
                              title: "email",
                              value: map["email"]),
                          GestureDetector(
                            onTap: () {
                              provider.showPhoneNumberDialogAlert(
                                  context, map["phone"]);
                            },
                            child: ResusableRow(
                                iconData: Icons.phone,
                                title: "phone",
                                value: map["phone"] == ""
                                    ? "xxxxxxxxxxxx"
                                    : map["phone"]),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text(
                          "Something Went weong",
                          style: TextStyle(
                              color: AppColors.alertColor,
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    }
                  })),
        );
      }),
    ));
  }
}

class ResusableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;
  ResusableRow(
      {super.key,
      required this.iconData,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            iconData,
            color: AppColors.primaryIconColor,
          ),
          title: Text(
            title,
            style: TextStyle(
                fontFamily: "AppFonts.sfProDisplayMedium",
                color: AppColors.primaryTextTextColor,
                fontSize: 16),
          ),
          trailing: Text(
            value,
            style: TextStyle(
                fontFamily: "AppFonts.sfProDisplayMedium",
                color: AppColors.primaryTextTextColor,
                fontSize: 16),
          ),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.5),
        )
      ],
    );
  }
}
