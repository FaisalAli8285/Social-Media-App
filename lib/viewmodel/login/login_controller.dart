import 'package:finallysocialapp/services/session_manager.dart';
import 'package:finallysocialapp/utils/Routes/routes_name.dart';
import 'package:finallysocialapp/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading {
    return _loading;
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(BuildContext context, String email, String password) {
    setLoading(true);
    try {
      _auth
          .signInWithEmailAndPassword(
              email: email.toString(), password: password.toString())
          .then((value) {
        setLoading(false);
        SessionController().userId = value.user!.uid.toString();
        Navigator.pushNamed(context, RouteName.dashboardview);

        Utils.toastMessage("user created successfully");
        setLoading(false);
      }).onError((error, StackTrace) {
        setLoading(false);
        print(error.toString());
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
