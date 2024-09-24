import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_user/src/models/forgot_password/forgot_password_spacer_options.dart";
import "package:flutter_user/src/models/forgot_password/forgot_password_translations.dart";
import "package:flutter_user/src/widgets/primary_button.dart";

class ForgotPasswordOptions {
  const ForgotPasswordOptions({
    this.forgotPasswordCustomAppBar,
    this.forgotPasswordBackgroundColor = const Color(0xffFAF9F6),
    this.forgotPasswordScreenPadding = const Padding(
      padding: EdgeInsets.symmetric(horizontal: 60),
    ),
    this.forgotPasswordSpacerOptions = const ForgotPasswordSpacerOptions(),
    this.maxFormWidth = 300,
    this.translations = const ForgotPasswordTranslations(),
    this.requestForgotPasswordButtonBuilder =
        _createRequestForgotPasswordButton,
  });

  final Color? forgotPasswordBackgroundColor;
  final AppBar? forgotPasswordCustomAppBar;
  final Padding forgotPasswordScreenPadding;
  final ForgotPasswordSpacerOptions forgotPasswordSpacerOptions;
  final double maxFormWidth;
  final ForgotPasswordTranslations translations;
  final ButtonBuilder requestForgotPasswordButtonBuilder;
}

Widget _createRequestForgotPasswordButton(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  bool disabled,
  OptionalAsyncCallback onDisabledPress,
  ForgotPasswordOptions options,
) =>
    Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: PrimaryButton(
          buttonTitle: options.translations.requestForgotPasswordButton,
          onPressed: !disabled ? onPressed : onDisabledPress,
        ),
      ),
    );

typedef OptionalAsyncCallback = FutureOr<void> Function();

typedef ButtonBuilder = Widget Function(
  BuildContext context,
  OptionalAsyncCallback onPressed,
  // ignore: avoid_positional_boolean_parameters
  bool isDisabled,
  OptionalAsyncCallback onDisabledPress,
  ForgotPasswordOptions options,
);
