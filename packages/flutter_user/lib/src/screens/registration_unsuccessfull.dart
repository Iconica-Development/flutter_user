import "package:flutter/material.dart";
import "package:flutter_user/src/models/auth_error_details.dart";
import "package:flutter_user/src/models/registration/registration_options.dart";
import "package:flutter_user/src/widgets/primary_button.dart";

/// Registration Unsuccessfull Screen
class RegistrationUnsuccessfull extends StatelessWidget {
  /// Registration Unsuccessfull Screen constructor
  const RegistrationUnsuccessfull({
    required this.onPressed,
    required this.errorDetails,
    required this.registrationOptions,
    super.key,
  });

  /// When the button is pressed this function is called
  final VoidCallback onPressed;

  final RegistrationOptions registrationOptions;

  /// Error details
  final AuthErrorDetails errorDetails;
  @override
  Widget build(BuildContext context) => Scaffold(
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
                      errorDetails.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      errorDetails.message,
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
