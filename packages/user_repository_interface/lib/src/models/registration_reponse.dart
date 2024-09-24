import "package:user_repository_interface/user_repository_interface.dart";

class RegistrationResponse<T> {
  const RegistrationResponse({
    required this.registrationSuccessful,
    required this.userObject,
    this.registrationError,
  });
  final bool registrationSuccessful;

  final T? userObject;
  final UserError? registrationError;
}
