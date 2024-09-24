import "package:flutter/material.dart";

/// Shows a loading popup.
Future<void> showLoadingIndicator(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
