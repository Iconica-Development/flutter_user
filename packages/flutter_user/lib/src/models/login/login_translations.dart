import "package:equatable/equatable.dart";

class LoginTranslations extends Equatable {
  const LoginTranslations({
    this.loginTitle = "log in",
    this.loginSubtitle,
    this.emailEmpty = "Please enter your email address",
    this.passwordEmpty = "Please enter your password",
    this.emailInvalid = "Please enter a valid email address",
    this.loginButton = "Log in",
    this.forgotPasswordButton = "Forgot password?",
    this.registrationButton = "Create account",
    this.biometricsLoginMessage = "Log in with biometrics",
  });

  /// Login title
  final String loginTitle;

  /// Login subtitle
  final String? loginSubtitle;

  final String emailInvalid;
  final String emailEmpty;
  final String passwordEmpty;
  final String loginButton;
  final String forgotPasswordButton;

  final String registrationButton;
  final String biometricsLoginMessage;

  @override
  List<Object?> get props => [
        loginTitle,
        loginSubtitle,
        emailEmpty,
        passwordEmpty,
        emailInvalid,
        loginButton,
        forgotPasswordButton,
        registrationButton,
        biometricsLoginMessage,
      ];
}
