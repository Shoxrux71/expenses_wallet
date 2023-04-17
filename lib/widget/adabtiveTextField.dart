import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class adabtiveTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  const adabtiveTextField(
      {super.key,
      this.keyboardType,
      required this.label,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? TextField(
            decoration: InputDecoration(
              labelText: label,
            ),
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
          )
        : CupertinoTextField(
            placeholder: label,
            controller: controller,
            padding: EdgeInsets.all(10),
            keyboardType: keyboardType ?? TextInputType.text,
          );
  }
}
