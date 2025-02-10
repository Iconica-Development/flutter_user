import "package:flutter/material.dart";
import "package:flutter_user/flutter_user.dart";

class FlutterUserOptions {
  FlutterUserOptions({
    this.loginOptions = const LoginOptions(),
    this.forgotPasswordOptions = const ForgotPasswordOptions(),
    this.beforeLogin,
    this.afterLogin,
    this.onBoardedUser,
    this.useOnboarding = false,
    this.onOnboardingComplete,
    this.onRegister,
    this.onForgotPassword,
    this.onRequestForgotPassword,
    this.onForgotPasswordSuccess,
    this.onForgotPasswordUnsuccessful,
    this.onRegistrationError,
    this.afterRegistration,
    this.afterRegistrationSuccess,
    this.afterRegistrationUnsuccessful,
    registrationOptions,
  }) : registrationOptions = registrationOptions ?? RegistrationOptions();

  final LoginOptions loginOptions;
  final ForgotPasswordOptions forgotPasswordOptions;
  final RegistrationOptions? registrationOptions;
  
  final Future Function(String email, String password)? beforeLogin;
  final Future Function()? afterLogin;
  final Future<OnboardedUserMixin?> Function()? onBoardedUser;
  final bool useOnboarding;
  final Future Function(Map<int, Map<String, dynamic>> onboardingResults)?
      onOnboardingComplete;
  final Future Function(String email, String password, BuildContext context)?
      onRegister;
  final Future Function(String email, BuildContext context)? onForgotPassword;
  final Future Function(String email)? onRequestForgotPassword;
  final Future Function()? onForgotPasswordSuccess;
  final Future Function()? onForgotPasswordUnsuccessful;
  final Future<int?> Function(String error)? onRegistrationError;
  final Future Function()? afterRegistration;
  final Future Function()? afterRegistrationSuccess;
  final Future Function()? afterRegistrationUnsuccessful;
}
