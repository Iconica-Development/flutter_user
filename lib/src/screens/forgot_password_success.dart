import "package:flutter/material.dart";
import "package:flutter_user/src/configuration/flutter_user_translations.dart";

/// Forgot Password Success
class ForgotPasswordSuccess extends StatelessWidget {
  /// Forgot Password Success constructor
  const ForgotPasswordSuccess({
    required this.onPressed,
    required this.translations,
    super.key,
  });

  /// When the button is pressed this function is called
  final VoidCallback onPressed;

  /// User translations
  final FlutterUserTranslations translations;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
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
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 16,
                      ),
                      child: SafeArea(
                        bottom: true,
                        child: FilledButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          onPressed: onPressed,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              translations.forgotPasswordSuccessButtonTitle,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
