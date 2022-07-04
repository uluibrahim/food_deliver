import 'package:flutter/material.dart';
import 'package:food_deliver/core/extension/context_extensions.dart';

class CustomTextFormField extends TextFormField {
  final BuildContext context;
  final TextEditingController? controllers;
  final String? label;
  final bool? obscureText;
  final String? Function(String?)? validators;
  final Function()? changeObscure;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;

  CustomTextFormField({
    Key? key,
    required this.context,
    this.controllers,
    this.label,
    this.obscureText = false,
    this.validators,
    this.textInputType,
    this.textInputAction,
    this.changeObscure,
  }) : super(
          key: key,
          controller: controllers,
          obscureText: obscureText ?? false,
          validator: validators,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          decoration: InputDecoration(
            label: Text(
              label ?? "",
              style: context.textTheme.subtitle1?.copyWith(color: Colors.white),
            ),
            suffixIcon: obscureText != null && changeObscure != null
                ? IconButton(
                    onPressed: () {
                      changeObscure();
                    },
                    icon: Icon(!obscureText
                        ? Icons.remove_red_eye_outlined
                        : Icons.visibility_off_outlined),
                  )
                : null,
          ),
        );
}
