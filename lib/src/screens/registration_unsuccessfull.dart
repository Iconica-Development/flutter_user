import "package:flutter/material.dart";
import "package:flutter_user/src/configuration/flutter_user_translations.dart";

/// Registration Unsuccessfull Screen
class RegistrationUnsuccessfull extends StatelessWidget {
  /// Registration Unsuccessfull Screen constructor
  const RegistrationUnsuccessfull({
    required this.onPressed,
    required this.translations,
    required this.error,
    super.key,
  });

  /// When the button is pressed this function is called
  final VoidCallback onPressed;

  /// User translations
  final FlutterUserTranslations translations;

  /// Error message
  final String error;
  @override
  Widget build(BuildContext context) {
    var isEmailError = error.contains("email-already-in-use");
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
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
                    isEmailError
                        ? translations.registrationEmailUnsuccessfullDescription
                        : translations
                            .registrationPasswordUnsuccessfullDescription,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
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
                            translations.registrationUnsuccessButtonTitle,
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
}
