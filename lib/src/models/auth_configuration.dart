// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_registration/flutter_registration.dart';
import 'package:flutter_user/src/models/onboarding_configuration.dart';

export 'package:flutter_login/flutter_login.dart';
export 'package:flutter_profile/flutter_profile.dart';
export 'package:flutter_registration/flutter_registration.dart';

@immutable
class AuthUserStoryConfiguration {
  const AuthUserStoryConfiguration({
    required this.onLogin,
    required this.loginOptions,
    this.registrationOptions,
    this.onRequestForgotPassword,
    this.onRegister,
    this.onForgotPassword,
    this.useRegistration = true,
    this.showForgotPassword = true,
    this.forgotPasswordDescription = const Center(
      child: Text('description'),
    ),
    this.loginPageBuilder,
    this.forgotPasswordTitle,
    this.onboardingConfiguration,
    this.onboardingScreen,
    this.useOnboarding = true,
  });

  //Login

  /// Called when the user logs in.
  final FutureOr<void> Function(String email, String password, BuildContext)
      onLogin;

  /// Called when the user registers.
  final FutureOr<void> Function(String email, String password)? onRegister;

  /// Called when the user forgot their password.
  final void Function(String)? onForgotPassword;

  /// Options for the login screen.
  final LoginOptions loginOptions;

  /// Whether to show the forgot password button.
  final bool showForgotPassword;

  //Registration

  /// Options for the registration screen.
  final RegistrationOptions Function(BuildContext context)? registrationOptions;

  /// Whether to use the registration screen.
  final bool useRegistration;

  //forgot-password
  /// Text to show on the forgot password screen.
  final Widget forgotPasswordDescription;

  /// Called when the user requests a password reset.
  final FutureOr<void> Function(String)? onRequestForgotPassword;

  /// Title to show on the forgot password screen.
  final Widget? forgotPasswordTitle;

  //onboarding

  /// Place your own onboarding here to override the default onboarding.
  final Widget? onboardingScreen;
  final bool? useOnboarding;

  /// Configuration for the onboarding screen.
  final OnboardingConfiguration? onboardingConfiguration;

  final Widget Function(BuildContext context, Widget loginWidget)?
      loginPageBuilder;

  // pagebuilder for beforeRegistrationPage

  // pagebuilder for afterRegistrationPage
}
