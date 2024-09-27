import 'dart:async';

import 'package:finallysocialapp/services/session_manager.dart';
import 'package:finallysocialapp/utils/Routes/routes_name.dart';
import 'package:finallysocialapp/view/LoginView/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void isLogin(BuildContext context) {
    final user = _auth.currentUser;
    if (user != null) {
      SessionController().userId = user.uid.toString();
      Timer(Duration(seconds: 3),
          () => Navigator.pushNamed(context, RouteName.dashboardview));
    } else {
      Timer(Duration(seconds: 3),
          () => Navigator.pushNamed(context, RouteName.loginView));
    }
  }
}
