import "package:flutter/material.dart";
import "package:flutter_user/flutter_user.dart";

/// Flutter User Options
class FlutterUserOptions {
  /// Flutter User Options Constructor
  const FlutterUserOptions({
    this.beforeLogin,
    this.afterLogin,
    this.onRegister,
    this.onRegistrationError,
    this.onForgotPassword,
    this.onRequestForgotPassword,
    this.onForgotPasswordSuccess,
    this.onForgotPasswordUnsuccessfull,
    this.beforeRegistration,
    this.afterRegistration,
    this.onRegistrationSuccess,
    this.onRegistrationUnsuccessfull,
    this.onboardingFinished,
    this.useOnboarding = true,
    this.onBoardedUser,
    this.beforeOnboardingFinished,
  });

  /// Called when the user logs in.
  final Future<void> Function(String email, String password)? beforeLogin;

  /// Called after the user logs in.
  final Future<void> Function()? afterLogin;

  /// Called when the user registers.
  final Future<void> Function(
    String email,
    String password,
    BuildContext context,
  )? onRegister;

  /// Called when the user requests a password reset.
  final Future<void> Function(String email, BuildContext context)?
      onForgotPassword;

  /// Called when the user requests a password reset.
  final Future<void> Function(String email)? onRequestForgotPassword;

  /// Called when the user successfully resets their password.
  final Future<void> Function()? onForgotPasswordSuccess;

  /// Called when the user unsuccessfully resets their password.
  final Future<void> Function()? onForgotPasswordUnsuccessfull;

  /// Called after the user registers.
  final Future<void> Function()? beforeRegistration;

  /// Called after the user registers.
  final Future<void> Function()? afterRegistration;

  /// Called when the user encounters an error during registration.
  final int? Function(String error)? onRegistrationError;

  /// Called when the user successfully registers.
  final Future<void> Function()? onRegistrationSuccess;

  /// Called when the user successfully registers.
  final Future<void> Function()? onRegistrationUnsuccessfull;

  /// Called when the user finishes the onboarding.
  final Future<void> Function(Map<int, Map<String, dynamic>> results)?
      onboardingFinished;

  /// Called when the user finishes the onboarding.
  final Future<void> Function(Map<int, Map<String, dynamic>> results)?
      beforeOnboardingFinished;

  /// Whether to use onboarding
  final bool useOnboarding;

  /// The user that is used when `useOnboarding` is true.
  /// This is used to determine if the user has completed the onboarding.
  /// This is mandatory when `useOnboarding` is true.
  final Future<OnboardedUserMixin?> Function()? onBoardedUser;
}
