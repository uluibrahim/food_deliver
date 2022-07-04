import 'package:flutter/material.dart';

class SearchTextField extends Container {
  final BuildContext context;
  final TextEditingController? controllers;
  final String? Function(String?)? validators;
  SearchTextField({
    Key? key,
    required this.context,
    this.controllers,
    this.validators,
  }) : super(
          key: key,
          decoration: const BoxDecoration(
            color: Color(0xffD9C9C9),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: TextFormField(
            controller: controllers,
            validator: validators,
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              label: Text("Search"),
            ),
          ),
        );
}
