import 'package:flutter/material.dart';
import 'package:food_deliver/core/extension/context_extensions.dart';

class PriceText extends Text {
  final String text;
  final BuildContext context;
  PriceText({Key? key, required this.text, required this.context})
      : super(
          key: key,
          "\$$text",
          style: context.textTheme.titleLarge?.copyWith(
            color: const Color(0xffB4AC03),
          ),
        );
}
