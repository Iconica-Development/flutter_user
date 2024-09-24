import "package:flutter/material.dart";
import "package:flutter_user/src/models/registration/registration_options.dart";
import "package:flutter_user/src/widgets/primary_button.dart";

/// Registration Success Screen
class RegistrationSuccess extends StatelessWidget {
  /// Registration Success Screen constructor
  const RegistrationSuccess({
    required this.onPressed,
    required this.registrationOptions,
    super.key,
  });

  /// When the button is pressed this function is called
  final VoidCallback onPressed;

  final RegistrationOptions registrationOptions;

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
                child: Text(
                  registrationOptions.translations.registrationSuccessTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: registrationOptions.maxFormWidth,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: SafeArea(
                    bottom: true,
                    child: PrimaryButton(
                      onPressed: onPressed,
                      buttonTitle: registrationOptions
                          .translations.registrationSuccessButtonTitle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
