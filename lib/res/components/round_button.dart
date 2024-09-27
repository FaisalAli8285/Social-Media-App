import 'package:finallysocialapp/res/colors.dart';
import 'package:flutter/material.dart';


class RoundButton extends StatefulWidget {
  String title;
  VoidCallback onTap;
  bool loading;
  final Color textColor;
  final Color butonColor;
  RoundButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.loading = false,
      this.butonColor = AppColors.primaryColor,
      this.textColor = AppColors.whiteColor});

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.loading?null:widget.onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.butonColor,
          borderRadius: BorderRadius.circular(50),
          
        ),
        child: widget.loading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 16, color: widget.textColor),
              )),
      ),
    );
  }
}
