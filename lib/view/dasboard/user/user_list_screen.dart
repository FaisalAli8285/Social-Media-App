import 'package:finallysocialapp/res/colors.dart';
import 'package:finallysocialapp/services/session_manager.dart';
import 'package:finallysocialapp/view/dasboard/chat/message_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("User");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, animation, index) {
            if (SessionController().userId.toString() ==
                snapshot.child("uid").value.toString()) {
              return Container();
            } else {
              return Card(
                child: ListTile(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: MessageScreen(
                          name: snapshot.child("name").value.toString(),
                          image: snapshot.child("profile").value.toString(),
                          email: snapshot.child("email").value.toString(),
                          receiverId: snapshot.child("uid").value.toString(),
                        ),
                        withNavBar: false);
                  },
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryButtonColor,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: snapshot.child("profile").value.toString() == ""
                        ? Icon(Icons.person)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(snapshot
                                    .child("profile")
                                    .value
                                    .toString()))),
                  ),
                  title: Text(snapshot.child("name").value.toString()),
                  subtitle: Text(snapshot.child("email").value.toString()),
                ),
              );
            }
          }),
    ));
  }
}
