import "package:flutter/material.dart";
import "package:flutter_user/src/models/auth_error_details.dart";

/// Show a [SnackBar] with the error message from the [LoginResponse].
Future<void> errorScaffoldMessenger(
  BuildContext context,
  AuthErrorDetails errorDetails,
) async {
  var theme = Theme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: theme.colorScheme.primary,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            errorDetails.title,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            errorDetails.message,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
