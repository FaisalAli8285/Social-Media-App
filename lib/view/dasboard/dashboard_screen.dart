import 'package:finallysocialapp/res/colors.dart';
import 'package:finallysocialapp/view/dasboard/profile_view.dart';
import 'package:finallysocialapp/view/dasboard/user/user_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> navScreens() {
    return [
      SafeArea(child: Text("Home")),
      Text("Chat"),
      Text("Add"),
      UserListScreen(),
      ProfileView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBArItem() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: Icon(
          Icons.home,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: Icon(
          Icons.message,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: Icon(
          Icons.add,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: Icon(
          Icons.home,
          color: Colors.grey.shade100,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_outline),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: Icon(
          Icons.person_outline,
          color: Colors.grey.shade100,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: navScreens(),
      items: _navBArItem(),
      controller: controller,
      backgroundColor: AppColors.otpHintColor,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
