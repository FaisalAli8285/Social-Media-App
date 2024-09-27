import 'package:finallysocialapp/services/session_manager.dart';
import 'package:finallysocialapp/utils/Routes/routes_name.dart';
import 'package:finallysocialapp/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SignupController with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("User");
  bool _loading = false;
  bool get loading {
    return _loading;
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void singUp(BuildContext context, String name, String email, String password) {
    setLoading(true);
    try {
      _auth
          .createUserWithEmailAndPassword(
              email: email.toString(), password: password.toString())
          .then((value) {
            SessionController().userId = value.user!.uid.toString();
        ref.child(value.user!.uid.toString()).set({
          "uid": value.user!.uid,
          "name":name,
          "email": value.user!.email.toString(),
          "onlineStatus": "none",
          "phone": "",
          "profile": "",
        }).then((value) {
          setLoading(false);
          Navigator.pushNamed(context, RouteName.dashboardview);
        }).onError(
          (error, stackTrace) {
            setLoading(false);
            Utils.toastMessage("user created successfully");
          },
        );
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
