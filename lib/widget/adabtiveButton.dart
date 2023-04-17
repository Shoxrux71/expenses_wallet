import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class adabtiveButton extends StatelessWidget {
  final String text;
  final Function() handler;
  final bool filled;

  const adabtiveButton(
      {super.key,
      this.filled = false,
      required this.handler,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? filled
            ? ElevatedButton(
                onPressed: () {
                  handler();
                },
                child: Text(text),
              )
            : TextButton(onPressed: handler, child: Text(text))
        : filled
            ? CupertinoButton(
                child: Text(text),
                onPressed: () {
                  handler();
                },
              )
            : CupertinoButton.filled(
                child: Text(text),
                onPressed: () {
                  handler();
                },
              );
  }
}
