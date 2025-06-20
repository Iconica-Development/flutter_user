///
class ForgotPasswordTranslations {
  /// Creates a [ForgotPasswordTranslations] with the provided values.
  const ForgotPasswordTranslations({
    required this.forgotPasswordTitle,
    required this.forgotPasswordDescription,
    required this.requestForgotPasswordButton,
    required this.forgotPasswordSuccessTitle,
    required this.forgotPasswordSuccessButtonTitle,
    required this.registrationSuccessTitle,
    required this.registrationSuccessButtonTitle,
    required this.forgotPasswordUnsuccessfullTitle,
    required this.forgotPasswordUnsuccessfullDescription,
    required this.forgotPasswordUnsuccessButtonTitle,
    required this.registrationUnsuccessfullTitle,
  });

  /// Creates a [ForgotPasswordTranslations] with default values.
  /// /// This constructor is used when no specific translations are provided.
  const ForgotPasswordTranslations.empty({
    this.forgotPasswordTitle = "forgot password",
    this.forgotPasswordDescription =
        "No worries. Enter your email address below"
            " so we can send you a link to reset your password.",
    this.requestForgotPasswordButton = "Send link",
    this.forgotPasswordSuccessTitle = "we’ve sent a link to your email address",
    this.forgotPasswordSuccessButtonTitle = "Okay",
    this.registrationSuccessTitle = "your registration was successful",
    this.registrationSuccessButtonTitle = "Finish",
    this.forgotPasswordUnsuccessfullTitle = "something went wrong",
    this.forgotPasswordUnsuccessfullDescription = "We couldn't find an account"
        " with that email address. Please try again.",
    this.forgotPasswordUnsuccessButtonTitle = "Try again",
    this.registrationUnsuccessfullTitle = "something went wrong",
  });

  final String forgotPasswordTitle;
  final String forgotPasswordDescription;
  final String requestForgotPasswordButton;
  final String forgotPasswordSuccessTitle;
  final String forgotPasswordSuccessButtonTitle;
  final String registrationSuccessTitle;
  final String registrationSuccessButtonTitle;
  final String forgotPasswordUnsuccessfullTitle;
  final String forgotPasswordUnsuccessfullDescription;
  final String forgotPasswordUnsuccessButtonTitle;
  final String registrationUnsuccessfullTitle;
}
