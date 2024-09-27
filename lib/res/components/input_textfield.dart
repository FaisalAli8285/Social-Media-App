import 'package:finallysocialapp/res/colors.dart';
import 'package:flutter/material.dart';


class InputTextfield extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  final TextInputType keyBoardType;
  final String hint;
  final FormFieldValidator onValidator;
  final bool obsecureText;
  int maxlength;
  Color fillcolor;
  final bool enable, autoFocus;

  InputTextfield({
    super.key,
    required this.myController,
    required this.onFieldSubmittedValue,
    required this.focusNode,
    required this.keyBoardType,
    required this.hint,
    required this.onValidator,
    this.enable = true,
    this.obsecureText = false,
    this.autoFocus = false,
    this.fillcolor=Colors.white,
    this.maxlength=1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        obscureText: obsecureText,
        onFieldSubmitted: onFieldSubmittedValue,
        validator: onValidator,
        cursorColor: AppColors.primaryTextTextColor,
        keyboardType: keyBoardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              TextStyle(color: AppColors.primaryTextTextColor.withOpacity(0.8)),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.textFieldDefaultFocus),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.alertColor),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.textFieldDefaultBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
