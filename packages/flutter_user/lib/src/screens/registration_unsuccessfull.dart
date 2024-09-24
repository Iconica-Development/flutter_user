import "package:flutter/material.dart";
import "package:flutter_user/src/models/registration/registration_options.dart";
import "package:flutter_user/src/widgets/primary_button.dart";

/// Registration Unsuccessfull Screen
class RegistrationUnsuccessfull extends StatelessWidget {
  /// Registration Unsuccessfull Screen constructor
  const RegistrationUnsuccessfull({
    required this.onPressed,
    required this.error,
    required this.registrationOptions,
    super.key,
  });

  /// When the button is pressed this function is called
  final VoidCallback onPressed;

  final RegistrationOptions registrationOptions;

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
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: registrationOptions.maxFormWidth,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    registrationOptions
                        .translations.registrationUnsuccessfullTitle,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isEmailError
                        ? registrationOptions.translations
                            .registrationEmailUnsuccessfullDescription
                        : registrationOptions.translations
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
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: registrationOptions.maxFormWidth,
              ),
              child: SafeArea(
                bottom: true,
                child: PrimaryButton(
                  buttonTitle: registrationOptions
                      .translations.registrationUnsuccessButtonTitle,
                  onPressed: onPressed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
