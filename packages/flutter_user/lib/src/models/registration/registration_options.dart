import "package:flutter/material.dart";
import "package:flutter_user/src/models/login/login_options.dart";
import "package:flutter_user/src/models/registration/auth_pass_field.dart";
import "package:flutter_user/src/models/registration/auth_step.dart";
import "package:flutter_user/src/models/registration/auth_text_field.dart";
import "package:flutter_user/src/models/registration/registration_spacer_options.dart";
import "package:flutter_user/src/models/registration/registration_translations.dart";

class RegistrationOptions {
  RegistrationOptions({
    this.translations = const RegistrationTranslations.empty(),
    this.accessibilityIdentifiers = const LoginAccessibilityIdentifiers.empty(),
    this.registrationBackgroundColor = const Color(0xffFAF9F6),
    this.maxFormWidth = 300,
    this.customAppbarBuilder = _createCustomAppBar,
    this.steps = const [],
    this.title,
    this.spacerOptions = const RegistrationSpacerOptions(),
    this.previousButtonBuilder,
    this.nextButtonBuilder,
    this.loginButton,
  }) {
    if (steps.isEmpty) {
      steps = getDefaultSteps(translations: translations);
    }
  }

  final RegistrationTranslations translations;

  /// Accessibility identifiers for the login elements of the userstory.
  /// The inputfields and buttons have accessibility identifiers and their own
  /// container so they are visible in the accessibility tree.
  /// This is used for testing purposes.
  final LoginAccessibilityIdentifiers accessibilityIdentifiers;

  final Color registrationBackgroundColor;
  final double maxFormWidth;
  final AppBar Function(String title) customAppbarBuilder;
  List<AuthStep> steps;
  final Widget? title;
  final RegistrationSpacerOptions spacerOptions;
  final Widget? Function(VoidCallback onPressed, String label, int step)?
      previousButtonBuilder;
  final Widget? Function(VoidCallback onPressed, String label, int step)?
      nextButtonBuilder;
  final Widget? loginButton;
}

AppBar _createCustomAppBar(String title) => AppBar(
      iconTheme: const IconThemeData(color: Colors.black, size: 16),
      title: Text(title),
      backgroundColor: Colors.transparent,
    );

List<AuthStep> getDefaultSteps({
  TextEditingController? emailController,
  TextEditingController? passController,
  bool passHidden = true,
  // ignore: avoid_positional_boolean_parameters
  Function(bool mainPass, bool value)? passHideOnChange,
  RegistrationTranslations translations =
      const RegistrationTranslations.empty(),
  Function(String title)? titleBuilder,
  Function(String label)? labelBuilder,
  TextStyle? textStyle,
  TextStyle? hintStyle,
  String? initialEmail,
}) =>
    [
      AuthStep(
        fields: [
          AuthTextField(
            name: "email",
            textEditingController: emailController,
            value: initialEmail ?? "",
            title: titleBuilder?.call(translations.defaultEmailTitle) ??
                Padding(
                  padding: const EdgeInsets.only(top: 180),
                  child: Text(
                    translations.defaultEmailTitle,
                  ),
                ),
            textInputType: TextInputType.emailAddress,
            textFieldDecoration: InputDecoration(
              hintStyle: hintStyle,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              label: labelBuilder?.call(translations.defaultEmailLabel),
              hintText: translations.defaultEmailHint,
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(),
            ),
            textStyle: textStyle,
            padding: const EdgeInsets.symmetric(vertical: 20),
            validators: [
              // ignore: avoid_dynamic_calls
              (email) => (email == null || email.isEmpty)
                  ? translations.defaultEmailEmpty
                  : null,
              (email) =>
                  RegExp(r"""(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])""")
                          .hasMatch(email!)
                      ? null
                      : translations.defaultEmailValidatorMessage,
            ],
          ),
        ],
      ),
      AuthStep(
        fields: [
          AuthPassField(
            name: "password",
            textEditingController: passController,
            title: titleBuilder?.call(translations.defaultPasswordTitle) ??
                Padding(
                  padding: const EdgeInsets.only(top: 180),
                  child: Text(
                    translations.defaultPasswordTitle,
                  ),
                ),
            textFieldDecoration: InputDecoration(
              hintStyle: hintStyle,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              label: labelBuilder?.call(translations.defaultPasswordLabel),
              hintText: translations.defaultPasswordHint,
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            textStyle: textStyle,
            validators: [
              (value) {
                // ignore: avoid_dynamic_calls
                if (value == null || value.isEmpty) {
                  return translations.defaultPasswordValidatorMessage;
                }
                // ignore: avoid_dynamic_calls
                if (value.length < 6) {
                  return translations.defaultPasswordToShortValidatorMessage;
                }
                return null;
              },
            ],
          ),
        ],
      ),
    ];
