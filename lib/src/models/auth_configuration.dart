// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_login_service/flutter_login_service.dart';
import 'package:flutter_registration/flutter_registration.dart';
import 'package:flutter_user/src/models/onboarding_configuration.dart';
import 'package:flutter_user/src/models/user.dart';

export 'package:flutter_login/flutter_login.dart';
export 'package:flutter_profile/flutter_profile.dart';
export 'package:flutter_registration/flutter_registration.dart';

@immutable
class AuthUserStoryConfiguration {
  const AuthUserStoryConfiguration({
    this.loginOptionsBuilder,
    this.loginServiceBuilder,
    this.afterLoginRoute,
    this.onLogin,
    this.userBuilder,
    this.registrationOptionsBuilder,
    this.onRequestForgotPassword,
    this.onRegister,
    this.onForgotPassword,
    this.useRegistration = true,
    this.showForgotPassword = true,
    this.forgotPasswordDescription,
    this.loginPageBuilder,
    this.registrationPageBuilder,
    this.forgotPasswordBuilder,
    this.forgotPasswordTitle,
    this.beforeRegistrationPage,
    this.afterRegistrationPage,
    this.pageOverlayBuilder,
    this.onboardingConfiguration,
    this.onboardingScreen,
    this.useOnboarding = true,
    this.afterLoginPage,
    this.onGetLoggedInUser,
    this.canPopOnboarding = true,
    this.loginErrorSnackbarBackgroundColor,
    this.loginErrorSnackbarTitleTextStyle,
    this.loginErrorSnackbarMessageTextStyle,
    this.useAfterRegistrationPage = true,
    this.registrationRepository,
  });

  /// Called when the user logs in.
  final FutureOr<void> Function(
    String email,
    String password,
    BuildContext context,
  )? onLogin;

  /// Called when the user registers.
  final FutureOr<void> Function(
    String email,
    String password,
    BuildContext context,
  )? onRegister;

  final Future<OnboardedUserMixin?> Function(BuildContext context)?
      onGetLoggedInUser;

  /// The login service to use.
  final LoginService Function(BuildContext)? loginServiceBuilder;

  /// The route to go to after the user logs in.
  final String? afterLoginRoute;

  /// Called when the user forgot their password.
  final void Function(String, BuildContext context)? onForgotPassword;

  /// Options for the login screen.
  final LoginOptions Function(BuildContext context)? loginOptionsBuilder;

  /// Wrap in a custom page
  final Widget Function(
    BuildContext context,
    Widget userPage,
  )? userBuilder;

  /// Whether to show the forgot password button.
  final bool showForgotPassword;

  //Registration

  /// Options for the registration screen.
  final RegistrationOptions Function(BuildContext context)?
      registrationOptionsBuilder;

  /// Whether to use the registration screen.
  final bool useRegistration;

  //forgot-password
  /// Text to show on the forgot password screen.
  final Widget? Function(BuildContext context)? forgotPasswordDescription;

  /// Called when the user requests a password reset.
  final FutureOr<void> Function(String email, BuildContext context)?
      onRequestForgotPassword;

  /// Title to show on the forgot password screen.
  final Widget Function(BuildContext context)? forgotPasswordTitle;

  //onboarding

  /// Place your own onboarding here to override the default onboarding.
  final Widget? onboardingScreen;

  /// Whether to use the onboarding screen.
  final bool useOnboarding;

  /// Configuration for the onboarding screen.
  final OnboardingConfiguration? onboardingConfiguration;

  final Widget Function(BuildContext context, Widget loginWidget)?
      loginPageBuilder;

  final Widget Function(
    BuildContext context,
    Widget registrationScreen,
  )? registrationPageBuilder;

  final Widget Function(
    BuildContext context,
    Widget forgotPasswordPage,
  )? forgotPasswordBuilder;

  /// This can be used to show something above the other pages.
  /// For instance to indicate that there is no internet.
  final WidgetBuilder? pageOverlayBuilder;

  // pagebuilder for beforeRegistrationPage
  final WidgetBuilder? beforeRegistrationPage;

  // pagebuilder for afterRegistrationPage
  final WidgetBuilder? afterRegistrationPage;

  // pagebuilder for afterLoginPAge
  final WidgetBuilder? afterLoginPage;

  // boolean for enabling or disabling popping from onboarding
  final bool canPopOnboarding;

  // login error snackbar background color
  final Color? loginErrorSnackbarBackgroundColor;

  // login error snackbar title text style
  final TextStyle? loginErrorSnackbarTitleTextStyle;

  // login error snackbar message text style
  final TextStyle? loginErrorSnackbarMessageTextStyle;

  // boolean for enabling or disabling after registration page
  final bool useAfterRegistrationPage;

  /// override the default registrationRepository of the default
  /// registrationOptions.
  final RegistrationRepository? registrationRepository;
}
