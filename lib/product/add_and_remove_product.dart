import 'package:flutter/material.dart';
import 'package:food_deliver/core/extension/context_extensions.dart';

class AddAndRemoveProduct extends Row {
  final BuildContext context;
  final void Function()? onTapAdd;
  final void Function()? onTapRemove;
  final int count;
  AddAndRemoveProduct(
      {Key? key,
      required this.context,
      required this.count,
      required this.onTapAdd,
      required this.onTapRemove})
      : super(
          key: key,
          children: [
            GestureDetector(
              onTap: onTapRemove,
              child: const Icon(Icons.remove_circle_outline,
                  color: Color(0xffCC1A74)),
            ),
            const SizedBox(width: 10),
            Text(
              count.toString(),
              style: context.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onTapAdd,
              child: const Icon(Icons.add_circle_outline,
                  color: Color(0xffCC1A74)),
            ),
          ],
        );
}
