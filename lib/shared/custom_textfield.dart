import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    this.labelText = 'Default',
    this.isObscure = false,
    this.focusBorderColor,
    this.cursorColor
  });
  final String labelText;
  final bool isObscure;
  final Color? focusBorderColor;
  final Color? cursorColor;
  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      obscureText: widget.isObscure,

    cursorColor: widget.cursorColor ?? theme.colorScheme.primary,


      decoration: InputDecoration(
        // suffix: widget.isObscure ? Icon(AppIcon.eyeIcon) : null,
        labelText: widget.labelText,
        labelStyle: theme.textTheme.bodyMedium!.copyWith(
          color: theme.colorScheme.secondary,
        ),

        

        enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(AppConstant.borderRadius),
            borderSide: BorderSide(color: theme.colorScheme.secondary,)
        ),

      

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
          borderSide: BorderSide(color: widget.focusBorderColor ??  theme.colorScheme.primary),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
          // borderSide: BorderSide(color: theme.colorScheme.primary, width: 0.5)
        ),
      ),
    );
  }
}
