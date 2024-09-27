import 'package:finallysocialapp/res/components/input_textfield.dart';
import 'package:finallysocialapp/res/components/round_button.dart';
import 'package:finallysocialapp/res/fonts.dart';
import 'package:finallysocialapp/utils/Routes/routes_name.dart';
import 'package:finallysocialapp/utils/utils.dart';
import 'package:finallysocialapp/viewmodel/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: ChangeNotifierProvider(
              create: (_) => SignupController(),
              child: Consumer<SignupController>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
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
                                fontSize: 25,
                                fontFamily: AppFonts.sfProDisplayBold),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Center(
                            child: Text(
                          "Enter your email address\nto register to your account",
                          style: TextStyle(
                              fontFamily: AppFonts.sfProDisplayMedium),
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
                                      myController: _nameController,
                                      onFieldSubmittedValue: (value) {
                                        Utils.fieldFocus(context,
                                            _nameFocusNode, _emailFocusNode);
                                      },
                                      focusNode: _nameFocusNode,
                                      keyBoardType: TextInputType.text,
                                      hint: "Username",
                                      onValidator: (value) {
                                        return value.isEmpty
                                            ? "Enter Username"
                                            : null;
                                      }),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  InputTextfield(
                                      myController: _emailController,
                                      onFieldSubmittedValue: (value) {
                                        Utils.fieldFocus(
                                            context,
                                            _emailFocusNode,
                                            _passwordFocusNode);
                                      },
                                      focusNode: _emailFocusNode,
                                      keyBoardType: TextInputType.emailAddress,
                                      hint: "Email",
                                      onValidator: (value) {
                                        return value.isEmpty
                                            ? "Enter Email"
                                            : null;
                                      }),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  InputTextfield(
                                      myController: _passwordController,
                                      onFieldSubmittedValue: (value) {},
                                      focusNode: _passwordFocusNode,
                                      keyBoardType:
                                          TextInputType.visiblePassword,
                                      hint: "password",
                                      onValidator: (value) {
                                        return value.isEmpty
                                            ? "Enter Password"
                                            : null;
                                      }),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        RoundButton(
                            title: "SignUP",
                            loading: provider.loading,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                provider.singUp(
                                    context,
                                    _nameController.text,
                                    _emailController.text,
                                    _passwordController.text);
                              }
                            }),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.loginView);
                          },
                          child: Text.rich(
                            TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                    fontFamily: AppFonts.sfProDisplayMedium,
                                    fontSize: 15),
                                children: [
                                  TextSpan(
                                    text: "Login",
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
                  );
                },
              )),
        ),
      ),
    );
  }
}
