import 'package:finallysocialapp/utils/Routes/routes_name.dart';
import 'package:finallysocialapp/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordController with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading {
    return _loading;
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgotPassword(
    BuildContext context,
    String email,
  ) {
    setLoading(true);
    try {
      _auth
          .sendPasswordResetEmail(
        email: email.toString(),
      )
          .then((value) {
        setLoading(false);

        Navigator.pushNamed(context, RouteName.loginView);

        Utils.toastMessage("please check your email to recover your password");
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
