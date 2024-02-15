import 'package:flutter/material.dart';

Future<bool> isKeyboardClosed(BuildContext context) async {
  var last = MediaQuery.of(context).viewInsets.bottom;
  double newBottom;

  while (context.mounted && !(MediaQuery.of(context).viewInsets.bottom == 0)) {
    if (context.mounted) {
      newBottom = MediaQuery.of(context).viewInsets.bottom;
      if (newBottom > last) {
        return false;
      }
      last = newBottom;
      await Future.delayed(
        const Duration(milliseconds: 50),
      );
    }
  }

  return true;
}
