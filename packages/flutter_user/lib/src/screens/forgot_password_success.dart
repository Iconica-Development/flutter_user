import "package:flutter/material.dart";
import "package:flutter_user/src/models/forgot_password/forgot_password_translations.dart";
import "package:flutter_user/src/widgets/primary_button.dart";

/// Forgot Password Success
class ForgotPasswordSuccess extends StatelessWidget {
  /// Forgot Password Success constructor
  const ForgotPasswordSuccess({
    required this.onRequestForgotPassword,
    this.translations = const ForgotPasswordTranslations(),
    super.key,
  });

  /// When the button is pressed this function is called
  final VoidCallback onRequestForgotPassword;
  final ForgotPasswordTranslations translations;

  /// User translations

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 300,
                ),
                child: Text(
                  translations.forgotPasswordSuccessTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 300,
                ),
                child: SafeArea(
                  bottom: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PrimaryButton(
                      buttonTitle:
                          translations.forgotPasswordSuccessButtonTitle,
                      onPressed: onRequestForgotPassword,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
