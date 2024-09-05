/// Flutter user translations
class FlutterUserTranslations {
  /// Default constructor
  const FlutterUserTranslations({
    this.loginTitle = "log in",
    this.forgotPasswordTitle = "forgot password",
    this.forgotPasswordDescription =
        "No worries. Enter your email address below"
            " so we can send you a link to reset your password.",
    this.imagePickerCancel = "Cancel",
    this.forgotPasswordSuccessTitle = "we’ve sent a link to your email address",
    this.forgotPasswordSuccessButtonTitle = "Okay",
    this.registrationSuccessTitle = "your registration was successful",
    this.registrationSuccessButtonTitle = "Finish",
    this.forgotPasswordUnsuccessfullTitle = "something went wrong",
    this.forgotPasswordUnsuccessfullDescription = "We couldn't find an account"
        " with that email address. Please try again.",
    this.forgotPasswordUnsuccessButtonTitle = "Try again",
    this.registrationUnsuccessfullTitle = "something went wrong",
    this.registrationEmailUnsuccessfullDescription =
        "This email address is already"
            " associated with an account. Please try again.",
    this.registrationPasswordUnsuccessfullDescription =
        "The password you entered"
            " is invalid. Please try again.",
    this.registrationUnsuccessButtonTitle = "Try again",
  });

  /// Login title
  final String loginTitle;

  /// Registration title
  final String forgotPasswordTitle;

  /// Registration description
  final String forgotPasswordDescription;

  /// Image picker cancel
  final String imagePickerCancel;

  /// Forgot password success title
  final String forgotPasswordSuccessTitle;

  /// Forgot password success button title
  final String forgotPasswordSuccessButtonTitle;

  /// Registration success title
  final String registrationSuccessTitle;

  /// Registration success button title
  final String registrationSuccessButtonTitle;

  /// Registration unsuccessfull title
  final String registrationUnsuccessfullTitle;

  /// Registration email unsuccessfull description
  final String registrationEmailUnsuccessfullDescription;

  /// Registration password unsuccessfull description
  final String registrationPasswordUnsuccessfullDescription;

  /// Registration unsuccess button title
  final String registrationUnsuccessButtonTitle;

  /// Forgot password unsuccessfull title
  final String forgotPasswordUnsuccessfullTitle;

  /// Forgot password unsuccessfull description
  final String forgotPasswordUnsuccessfullDescription;

  /// Forgot password unsuccess button title
  final String forgotPasswordUnsuccessButtonTitle;
}
