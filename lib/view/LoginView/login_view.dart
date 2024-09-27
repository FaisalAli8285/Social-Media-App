import 'package:finallysocialapp/res/components/input_textfield.dart';
import 'package:finallysocialapp/res/components/round_button.dart';
import 'package:finallysocialapp/res/fonts.dart';
import 'package:finallysocialapp/utils/Routes/routes_name.dart';
import 'package:finallysocialapp/utils/utils.dart';
import 'package:finallysocialapp/viewmodel/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
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
                  "Welcome to Chatting App",
                  style: TextStyle(
                      fontSize: 25, fontFamily: AppFonts.sfProDisplayBold),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Center(
                  child: Text(
                "Enter your email address\nto connect to your account",
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
                            onFieldSubmittedValue: (value) {
                              Utils.fieldFocus(
                                  context, _emailFocusNode, _passwordFocusNode);
                            },
                            focusNode: _emailFocusNode,
                            keyBoardType: TextInputType.emailAddress,
                            hint: "Email",
                            onValidator: (value) {
                              return value.isEmpty ? "Email" : null;
                            }),
                        InputTextfield(
                            myController: _passwordController,
                            onFieldSubmittedValue: (value) {},
                            focusNode: _passwordFocusNode,
                            keyBoardType: TextInputType.emailAddress,
                            hint: "password",
                            onValidator: (value) {
                              return value.isEmpty ? "Password" : null;
                            }),
                      ],
                    ),
                  )),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.forgotview);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Forgot Password? ",
                      style: TextStyle(
                          fontFamily: AppFonts.sfProDisplayBold,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              ChangeNotifierProvider(
                create: (context) => LoginController(),
                child: Consumer<LoginController>(
                  builder: (context, provider, child) {
                    return RoundButton(
                        title: "Login",
                        loading: provider.loading,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            provider.login(context, _emailController.text,
                                _passwordController.text);
                          }
                        });
                  },
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.signupView);
                },
                child: Text.rich(
                  TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                          fontFamily: AppFonts.sfProDisplayMedium,
                          fontSize: 15),
                      children: [
                        TextSpan(
                          text: "SignUp",
                          style: TextStyle(
                              fontFamily: AppFonts.sfProDisplayBold,
                              fontSize: 15,
                              decoration: TextDecoration.underline),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
