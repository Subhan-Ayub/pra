// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ReuseableTextfield extends StatelessWidget {
  var controller;
  String? labelText;
  Function(String)? onchange;
  ReuseableTextfield({this.controller,this.onchange, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onchange,
      controller: controller,
        decoration: InputDecoration(
      label: Text('$labelText'),
      constraints: const BoxConstraints(
        maxHeight: 50.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0), // Adjust corner radius
      ),
    ));
  }
}
