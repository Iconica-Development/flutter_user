import "package:flutter/material.dart";
import "package:flutter_login/flutter_login.dart";

/// Default login options
LoginOptions defaultLoginOptions(BuildContext context) {
  var theme = Theme.of(context);
  return LoginOptions(
    // login
    loginBackgroundColor: theme.scaffoldBackgroundColor,
    emailTextStyle: theme.textTheme.bodyMedium,
    emailDecoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      hintText: "Email address",
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(),
      hintStyle: theme.textTheme.bodyMedium?.copyWith(
        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
      ),
    ),
    passwordTextStyle: theme.textTheme.bodyMedium,
    passwordDecoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      hintText: "Password",
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(),
      hintStyle: theme.textTheme.bodyMedium?.copyWith(
        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
      ),
    ),
    forgotPasswordButtonBuilder:
        (context, onPressed, isDisabled, onDisabledPress, options) =>
            TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: isDisabled ? onDisabledPress : onPressed,
      child: Text(
        "Forgot password?",
        style: theme.textTheme.labelSmall!.copyWith(
          decoration: TextDecoration.underline,
          letterSpacing: 0.5,
        ),
      ),
    ),
    spacers: const LoginSpacerOptions(
      spacerBeforeTitle: 8,
      spacerAfterTitle: 2,
      spacerAfterForm: 1,
      spacerAfterButton: 12,
      formFlexValue: 2,
    ),

    // forgot password
    forgotPasswordBackgroundColor: theme.scaffoldBackgroundColor,
    forgotPasswordCustomAppBar: AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.black, size: 16),
    ),
    loginButtonBuilder:
        (context, onPressed, isDisabled, onDisabledPress, options) => Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FilledButton(
                onPressed: () async =>
                    !isDisabled ? await onPressed() : await onDisabledPress(),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    options.translations.loginButton,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
