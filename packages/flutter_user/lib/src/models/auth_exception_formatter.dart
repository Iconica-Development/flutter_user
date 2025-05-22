import "package:flutter_user/flutter_user.dart";
import "package:flutter_user/src/models/auth_error_details.dart";

/// A class to format [AuthException] into user-friendly [AuthErrorDetails].
///
/// This allows for easy localization and customization of authentication error
/// messages presented to the user.
class AuthExceptionFormatter {
  /// Creates a formatter with custom error messages.
  const AuthExceptionFormatter({
    this.userNotFound,
    this.wrongPassword,
    this.emailAlreadyInUse,
    this.weakPassword,
    this.invalidEmail,
    this.userDisabled,
    this.tooManyRequests,
    this.networkError,
    this.generic,
  });

  /// Dutch implementation of auth exception texts
  factory AuthExceptionFormatter.dutch() => const AuthExceptionFormatter(
        userNotFound: AuthErrorDetails(
          title: "Gebruiker niet gevonden",
          message: "We hebben geen account gevonden met dit e-mailadres.",
        ),
        wrongPassword: AuthErrorDetails(
          title: "Verkeerd wachtwoord",
          message: "Het ingevoerde wachtwoord is onjuist.",
        ),
        emailAlreadyInUse: AuthErrorDetails(
          title: "E-mailadres in gebruik",
          message: "Er bestaat al een account met dit e-mailadres.",
        ),
        weakPassword: AuthErrorDetails(
          title: "Zwak wachtwoord",
          message: "Het wachtwoord is te zwak. Gebruik minstens 6 tekens.",
        ),
        invalidEmail: AuthErrorDetails(
          title: "Ongeldig e-mailadres",
          message: "Het ingevoerde e-mailadres is ongeldig.",
        ),
        userDisabled: AuthErrorDetails(
          title: "Gebruiker gedeactiveerd",
          message: "Deze gebruiker is gedeactiveerd door een beheerder.",
        ),
        tooManyRequests: AuthErrorDetails(
          title: "Te veel pogingen",
          message: "Te veel foutieve pogingen. Probeer het later opnieuw.",
        ),
        networkError: AuthErrorDetails(
          title: "Netwerkfout",
          message: "Kan geen verbinding maken. Controleer je internet.",
        ),
        generic: AuthErrorDetails(
          title: "Authenticatiefout",
          message: "Er is een fout opgetreden. Probeer het later opnieuw.",
        ),
      );

  /// English implementation of auth exception texts
  factory AuthExceptionFormatter.english() => const AuthExceptionFormatter(
        userNotFound: AuthErrorDetails(
          title: "User not found",
          message: "No account found with this email address.",
        ),
        wrongPassword: AuthErrorDetails(
          title: "Incorrect password",
          message: "The entered password is incorrect.",
        ),
        emailAlreadyInUse: AuthErrorDetails(
          title: "Email already in use",
          message: "An account already exists with this email address.",
        ),
        weakPassword: AuthErrorDetails(
          title: "Weak password",
          message: "The password is too weak. Use at least 6 characters.",
        ),
        invalidEmail: AuthErrorDetails(
          title: "Invalid email",
          message: "The entered email address is invalid.",
        ),
        userDisabled: AuthErrorDetails(
          title: "User disabled",
          message: "This account has been disabled by an administrator.",
        ),
        tooManyRequests: AuthErrorDetails(
          title: "Too many attempts",
          message: "Too many failed attempts. Please try again later.",
        ),
        networkError: AuthErrorDetails(
          title: "Network error",
          message: "Could not connect. Please check your internet connection.",
        ),
        generic: AuthErrorDetails(
          title: "Authentication error",
          message: "An unexpected error occurred. Please try again later.",
        ),
      );

  final AuthErrorDetails? userNotFound;
  final AuthErrorDetails? wrongPassword;
  final AuthErrorDetails? emailAlreadyInUse;
  final AuthErrorDetails? weakPassword;
  final AuthErrorDetails? invalidEmail;
  final AuthErrorDetails? userDisabled;
  final AuthErrorDetails? tooManyRequests;
  final AuthErrorDetails? networkError;
  final AuthErrorDetails? generic;

  /// Creates a new formatter by overriding existing error details.
  AuthExceptionFormatter copyWith({
    AuthErrorDetails? userNotFound,
    AuthErrorDetails? wrongPassword,
    AuthErrorDetails? emailAlreadyInUse,
    AuthErrorDetails? weakPassword,
    AuthErrorDetails? invalidEmail,
    AuthErrorDetails? userDisabled,
    AuthErrorDetails? tooManyRequests,
    AuthErrorDetails? networkError,
    AuthErrorDetails? generic,
  }) =>
      AuthExceptionFormatter(
        userNotFound: userNotFound ?? this.userNotFound,
        wrongPassword: wrongPassword ?? this.wrongPassword,
        emailAlreadyInUse: emailAlreadyInUse ?? this.emailAlreadyInUse,
        weakPassword: weakPassword ?? this.weakPassword,
        invalidEmail: invalidEmail ?? this.invalidEmail,
        userDisabled: userDisabled ?? this.userDisabled,
        tooManyRequests: tooManyRequests ?? this.tooManyRequests,
        networkError: networkError ?? this.networkError,
        generic: generic ?? this.generic,
      );

  /// Formats the given [AuthException] into human-readable details.
  ///
  /// This method uses pattern matching to find the appropriate error message.
  /// If a specific message isn't provided for an exception type, it falls
  /// back to the generic message, and finally to a default message using
  /// the raw error code and message.
  AuthErrorDetails format(AuthException exception) => switch (exception) {
        UserNotFoundError() when userNotFound != null => userNotFound!,
        WrongPasswordError() when wrongPassword != null => wrongPassword!,
        EmailAlreadyInUseError() when emailAlreadyInUse != null =>
          emailAlreadyInUse!,
        WeakPasswordError() when weakPassword != null => weakPassword!,
        InvalidEmailError() when invalidEmail != null => invalidEmail!,
        UserDisabledError() when userDisabled != null => userDisabled!,
        TooManyRequestsError() when tooManyRequests != null => tooManyRequests!,
        NetworkError() when networkError != null => networkError!,
        _ => generic ??
            AuthErrorDetails(
              title: exception.code ?? "Authentication failed",
              message: exception.message ?? "An unknown error occurred.",
            ),
      };
}
