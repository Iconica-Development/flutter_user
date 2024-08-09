import "package:flutter/material.dart";
import "package:flutter_login_service/flutter_login_service.dart";

/// Show a [SnackBar] with the error message from the [LoginResponse].
Future<void> errorScaffoldMessenger(
  BuildContext context,
  LoginResponse result,
) async {
  var theme = Theme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: theme.colorScheme.primary,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            result.loginError!.title,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            result.loginError!.message,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
