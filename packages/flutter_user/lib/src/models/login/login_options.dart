import "dart:async";

import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:flutter_user/src/models/login/login_spacer_options.dart";
import "package:flutter_user/src/models/login/login_translations.dart";
import "package:flutter_user/src/services/login_validation.dart";
import "package:flutter_user/src/services/validation_service.dart";

@immutable
class LoginOptions extends Equatable {
  const LoginOptions({
    this.image,
    this.spacers = const LoginSpacerOptions(),
    this.translations = const LoginTranslations(),
    this.validationService,
    this.biometricsOptions = const LoginBiometricsOptions(),
    this.accessibilityIdentifiers = const LoginAccessibilityIdentifiers.empty(),
    this.maxFormWidth = 300,
    this.initialEmail = "",
    this.initialPassword = "",
    this.emailTextAlign = TextAlign.start,
    this.emailTextStyle,
    this.passwordTextAlign = TextAlign.start,
    this.passwordTextStyle,
    this.showObscurePassword = true,
    this.suffixIconSize,
    this.suffixIconPadding,
    this.loginBackgroundColor = const Color(0xffFAF9F6),
    this.forgotPasswordButtonBuilder = _createForgotPasswordButton,
    this.loginButtonBuilder = _createLoginButton,
    this.registrationButtonBuilder = _createRegisterButton,
    this.emailInputContainerBuilder = _createEmailInputContainer,
    this.passwordInputContainerBuilder = _createPasswordInputContainer,
    this.emailDecoration = const InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      labelText: "Email address",
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff71C6D1),
        ),
      ),
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    ),
    this.passwordDecoration = const InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      labelText: "Password",
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff71C6D1),
        ),
      ),
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    ),
  });

  final Widget? image;
  final LoginSpacerOptions spacers;
  final LoginTranslations translations;
  final ValidationService? validationService;
  final double maxFormWidth;
  final String initialEmail;
  final String initialPassword;
  final TextAlign emailTextAlign;
  final TextStyle? emailTextStyle;
  final InputDecoration emailDecoration;
  final TextAlign passwordTextAlign;
  final TextStyle? passwordTextStyle;
  final InputDecoration passwordDecoration;
  final bool showObscurePassword;
  final double? suffixIconSize;
  final EdgeInsetsGeometry? suffixIconPadding;
  final LoginButtonBuilder forgotPasswordButtonBuilder;
  final LoginButtonBuilder loginButtonBuilder;
  final LoginButtonBuilder registrationButtonBuilder;
  final Color loginBackgroundColor;
  final InputContainerBuilder emailInputContainerBuilder;
  final InputContainerBuilder passwordInputContainerBuilder;

  /// Configuration class for the biometrics login options.
  final LoginBiometricsOptions biometricsOptions;

  /// Accessibility identifiers for the login elements of the userstory.
  /// The inputfields and buttons have accessibility identifiers and their own
  /// container so they are visible in the accessibility tree.
  /// This is used for testing purposes.
  final LoginAccessibilityIdentifiers accessibilityIdentifiers;

  ValidationService get validations =>
      validationService ?? LoginValidationService(this);

  @override
  List<Object?> get props => [
        // image is not added because it is a widget without Equatable
        spacers,
        translations,
        validationService,
        maxFormWidth,
        initialEmail,
        initialPassword,
        emailTextAlign,
        emailTextStyle,
        passwordTextAlign,
        passwordTextStyle,
        showObscurePassword,
        suffixIconSize,
        suffixIconPadding,
        loginBackgroundColor,
        forgotPasswordButtonBuilder.runtimeType,
        loginButtonBuilder.runtimeType,
        registrationButtonBuilder.runtimeType,
        emailInputContainerBuilder.runtimeType,
        passwordInputContainerBuilder.runtimeType,
      ];
}

class LoginBiometricsOptions extends Equatable {
  const LoginBiometricsOptions({
    this.loginWithBiometrics = false,
    this.triggerBiometricsAutomatically = false,
    this.allowBiometricsAlternative = true,
    this.onBiometricsSuccess,
    this.onBiometricsError,
    this.onBiometricsFail,
  });

  /// Ask the user to login with biometrics instead of email and password.
  final bool loginWithBiometrics;

  /// Allow the user to login with biometrics even if they have no biometrics
  /// set up on their device. This will use their device native login methods.
  final bool allowBiometricsAlternative;

  /// Automatically open the native biometrics UI instead of waiting for the
  /// user to press the biometrics button
  final bool triggerBiometricsAutomatically;

  /// The callback function to be called when the biometrics login is
  /// successful.
  final LoginOptionalAsyncCallback? onBiometricsSuccess;

  /// The callback function to be called when the biometrics login fails.
  final LoginOptionalAsyncCallback? onBiometricsFail;

  /// The callback function to be called when the biometrics login errors.
  final LoginOptionalAsyncCallback? onBiometricsError;

  @override
  List<Object?> get props => [
        loginWithBiometrics,
        triggerBiometricsAutomatically,
        allowBiometricsAlternative,
        onBiometricsSuccess,
        onBiometricsFail,
        onBiometricsError,
      ];
}

/// Accessibility identifiers for the login widgets of the userstory.
class LoginAccessibilityIdentifiers extends Equatable {
  /// Default [LoginAccessibilityIdentifiers] constructor where all the
  /// identifiers are required. This is to ensure that apps automatically break
  /// when new identifiers are added.
  const LoginAccessibilityIdentifiers({
    required this.emailTextFieldIdentifier,
    required this.passwordTextFieldIdentifier,
    required this.loginButtonIdentifier,
    required this.forgotPasswordButtonIdentifier,
    required this.requestForgotPasswordButtonIdentifier,
    required this.registrationButtonIdentifier,
    required this.biometricsButtonIdentifier,
  });

  /// Empty [LoginAccessibilityIdentifiers] constructor where all the
  /// identifiers are already set to their default values. You can override all
  /// or some of the default values.
  const LoginAccessibilityIdentifiers.empty({
    this.emailTextFieldIdentifier = "email_text_field",
    this.passwordTextFieldIdentifier = "password_text_field",
    this.loginButtonIdentifier = "login_button",
    this.forgotPasswordButtonIdentifier = "forgot_password_button",
    this.requestForgotPasswordButtonIdentifier =
        "request_forgot_password_button",
    this.registrationButtonIdentifier = "registration_button",
    this.biometricsButtonIdentifier = "biometrics_button",
  });

  /// Identifier for the email text field.
  final String emailTextFieldIdentifier;

  /// Identifier for the password text field.
  final String passwordTextFieldIdentifier;

  /// Identifier for the login button.
  final String loginButtonIdentifier;

  /// Identifier for the forgot password button.
  final String forgotPasswordButtonIdentifier;

  /// Identifier for the request forgot password button.
  final String requestForgotPasswordButtonIdentifier;

  /// Identifier for the registration button.
  final String registrationButtonIdentifier;

  /// Identifier for the biometrics button.
  final String biometricsButtonIdentifier;

  @override
  List<Object?> get props => [
        emailTextFieldIdentifier,
        passwordTextFieldIdentifier,
        loginButtonIdentifier,
        forgotPasswordButtonIdentifier,
        requestForgotPasswordButtonIdentifier,
        registrationButtonIdentifier,
        biometricsButtonIdentifier,
      ];
}

Widget _createForgotPasswordButton(
  BuildContext context,
  LoginOptionalAsyncCallback onPressed,
  bool disabled,
  LoginOptionalAsyncCallback onDisabledPress,
  LoginOptions options,
) =>
    Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: TextButton(
        onPressed: !disabled ? onPressed : onDisabledPress,
        child: Text(
          options.translations.forgotPasswordButton,
          style: const TextStyle(
            decoration: TextDecoration.underline,
            decorationColor: Color(0xff8D8D8D),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xff8D8D8D),
          ),
        ),
      ),
    );

Widget _createLoginButton(
  BuildContext context,
  LoginOptionalAsyncCallback onPressed,
  bool disabled,
  LoginOptionalAsyncCallback onDisabledPress,
  LoginOptions options,
) =>
    Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        child: FilledButton(
          onPressed: () async =>
              !disabled ? await onPressed() : await onDisabledPress(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              options.translations.loginButton,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );

Widget _createRegisterButton(
  BuildContext context,
  LoginOptionalAsyncCallback onPressed,
  bool disabled,
  LoginOptionalAsyncCallback onDisabledPress,
  LoginOptions options,
) =>
    Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: TextButton(
        onPressed: !disabled ? onPressed : onDisabledPress,
        child: Text(
          options.translations.registrationButton,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                decoration: TextDecoration.underline,
              ),
        ),
      ),
    );

Widget _createEmailInputContainer(Widget child) => Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: child,
    );

Widget _createPasswordInputContainer(Widget child) => child;

typedef LoginButtonBuilder = Widget Function(
  BuildContext context,
  LoginOptionalAsyncCallback onPressed,
  // ignore: avoid_positional_boolean_parameters
  bool isDisabled,
  LoginOptionalAsyncCallback onDisabledPress,
  LoginOptions options,
);

typedef InputContainerBuilder = Widget Function(
  Widget child,
);

typedef LoginOptionalAsyncCallback = FutureOr<void> Function();
