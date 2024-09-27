import 'dart:io';

import 'package:finallysocialapp/res/colors.dart';
import 'package:finallysocialapp/res/components/input_textfield.dart';
import 'package:finallysocialapp/services/session_manager.dart';
import 'package:finallysocialapp/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController with ChangeNotifier {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  bool _loading = false;
  bool get loading {
    return _loading;
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  DatabaseReference ref = FirebaseDatabase.instance.ref().child("User");
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;
  Future pickedGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
    }
    uploadImage(context);
    notifyListeners();
  }

  Future pickedCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
    }
    uploadImage(context);
    notifyListeners();
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      pickedCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.camera),
                    title: Text("Camera"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      pickedGalleryImage(context);
                    },
                    leading: Icon(Icons.browse_gallery),
                    title: Text("Gallery"),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    //upload image on firebase storage
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref("/profile" + SessionController().userId.toString());
    firebase_storage.UploadTask uploadTask =
        //Upload a [File] from the filesystem. The file must exist.
        storageRef.putFile(File(image!.path).absolute);
    //upload image on server
    await Future.value(uploadTask);
    //download path url
    final newUrl = await storageRef.getDownloadURL();
    //update profile according to user id
    ref.child(SessionController().userId.toString()).update({
      "profile": newUrl,
    }).then((value) {
      setLoading(false);
      _image = null;
      Utils.toastMessage("Profile Updated");
    }).onError((error, StackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }

  Future<void> showUserNameDialogAlert(BuildContext context, String name) {
    nameController.text = name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Update username",
                style: TextStyle(
                    fontFamily: "AppFonts.sfProDisplayMedium",
                    color: AppColors.primaryTextTextColor,
                    fontSize: 20),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextfield(
                      myController: nameController,
                      onFieldSubmittedValue: (value) {},
                      focusNode: phoneFocusNode,
                      keyBoardType: TextInputType.phone,
                      hint: "update name",
                      onValidator: (value) {})
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(SessionController().userId.toString()).update(
                        {"name": nameController.text.toString()}).then((value) {
                      nameController.clear();
                      Utils.toastMessage("updated");
                    }).onError((error, StackTrace) {
                      Utils.toastMessage(error.toString());
                    });
                  },
                  child: Text(
                    "update",
                    style: TextStyle(
                        fontFamily: "AppFonts.sfProDisplayMedium",
                        color: AppColors.primaryTextTextColor,
                        fontSize: 16),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "cancel",
                    style: TextStyle(
                        fontFamily: "AppFonts.sfProDisplayMedium",
                        color: AppColors.primaryTextTextColor,
                        fontSize: 16),
                  )),
            ],
          );
        });
  }
  Future<void> showPhoneNumberDialogAlert(BuildContext context, String phoneNUmber) {
    nameController.text = phoneNUmber;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "update phone",
                style: TextStyle(
                    fontFamily: "AppFonts.sfProDisplayMedium",
                    color: AppColors.primaryTextTextColor,
                    fontSize: 20),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextfield(
                      myController: phoneController,
                      onFieldSubmittedValue: (value) {},
                      focusNode: nameFocusNode,
                      keyBoardType: TextInputType.text,
                      hint: "update phone",
                      onValidator: (value) {})
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(SessionController().userId.toString()).update(
                        {"phone": phoneController.text.toString()}).then((value) {
                      phoneController.clear();
                      Utils.toastMessage("updated");
                    }).onError((error, StackTrace) {
                      Utils.toastMessage(error.toString());
                    });
                  },
                  child: Text(
                    "update",
                    style: TextStyle(
                        fontFamily: "AppFonts.sfProDisplayMedium",
                        color: AppColors.primaryTextTextColor,
                        fontSize: 16),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "cancel",
                    style: TextStyle(
                        fontFamily: "AppFonts.sfProDisplayMedium",
                        color: AppColors.primaryTextTextColor,
                        fontSize: 16),
                  )),
            ],
          );
        });
  }
}
