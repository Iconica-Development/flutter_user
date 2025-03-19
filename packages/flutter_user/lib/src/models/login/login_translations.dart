class LoginTranslations {
  const LoginTranslations({
    this.emailEmpty = "Please enter your email address",
    this.passwordEmpty = "Please enter your password",
    this.emailInvalid = "Please enter a valid email address",
    this.loginButton = "Log in",
    this.forgotPasswordButton = "Forgot password?",
    this.registrationButton = "Create account",
  });

  final String emailInvalid;
  final String emailEmpty;
  final String passwordEmpty;
  final String loginButton;
  final String forgotPasswordButton;

  final String registrationButton;
}
