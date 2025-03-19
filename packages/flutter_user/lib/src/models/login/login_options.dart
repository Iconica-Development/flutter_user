import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_user/src/models/login/login_translations.dart";
import "package:flutter_user/src/services/login_validation.dart";
import "package:flutter_user/src/services/validation_service.dart";

class LoginOptions {
  const LoginOptions({
    this.translations = const LoginTranslations(),
    this.validationService,
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
  final InputContainerBuilder emailInputContainerBuilder;
  final InputContainerBuilder passwordInputContainerBuilder;

  ValidationService get validations =>
      validationService ?? LoginValidationService(this);
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
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 8,
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
          ),
        ],
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
