import 'package:finallysocialapp/res/components/input_textfield.dart';
import 'package:finallysocialapp/res/components/round_button.dart';
import 'package:finallysocialapp/res/fonts.dart';
import 'package:finallysocialapp/viewmodel/forgotpassword/forgot_password_controller.dart';
import 'package:finallysocialapp/viewmodel/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  final TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  final _emailFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();

    _emailFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Center(
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      fontSize: 25, fontFamily: AppFonts.sfProDisplayBold),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Center(
                  child: Text(
                "Enter your email address\nto recover your account",
                style: TextStyle(fontFamily: AppFonts.sfProDisplayMedium),
              )),
              SizedBox(
                height: height * 0.06,
              ),
              Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.03, left: height * 0.02),
                    child: Column(
                      children: [
                        InputTextfield(
                            myController: _emailController,
                            onFieldSubmittedValue: (value) {},
                            focusNode: _emailFocusNode,
                            keyBoardType: TextInputType.emailAddress,
                            hint: "Email",
                            onValidator: (value) {
                              return value.isEmpty ? "Email" : null;
                            }),
                      ],
                    ),
                  )),
              SizedBox(
                height: height * 0.04,
              ),
              ChangeNotifierProvider(
                create: (context) => ForgotPasswordController(),
                child: Consumer<ForgotPasswordController>(
                  builder: (context, provider, child) {
                    return RoundButton(
                        title: "Recover",
                        loading: provider.loading,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            provider.forgotPassword(context, _emailController.text);
                          }
                        });
                  },
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
