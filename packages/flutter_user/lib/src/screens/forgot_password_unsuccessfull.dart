import "package:flutter/material.dart";
import "package:flutter_user/src/models/forgot_password/forgot_password_translations.dart";
import "package:flutter_user/src/widgets/primary_button.dart";

/// ForgotPasswordUnsuccessfull
class ForgotPasswordUnsuccessfull extends StatelessWidget {
  /// ForgotPasswordUnsuccessfull constructor
  const ForgotPasswordUnsuccessfull({
    required this.onPressed,
    required this.translations,
    super.key,
  });

  /// When the button is pressed this function is called
  final VoidCallback onPressed;

  final ForgotPasswordTranslations translations;

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      translations.forgotPasswordUnsuccessfullTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      translations.forgotPasswordUnsuccessfullDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
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
                          translations.forgotPasswordUnsuccessButtonTitle,
                      onPressed: onPressed,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
