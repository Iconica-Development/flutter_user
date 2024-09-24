import "package:user_repository_interface/user_repository_interface.dart";

/// A [RequestPasswordResponse] object is returned from a password
/// reset request. If the request was successful, [requestSuccesfull]
/// will be true. If the request was not successful, [requestSuccesfull]
/// will be false and [requestPasswordError] will contain an [Error]
/// object with the error title and message.
class RequestPasswordResponse<T> {
  const RequestPasswordResponse({
    required this.requestSuccesfull,
    this.requestPasswordError,
  });
  final bool requestSuccesfull;

  final UserError? requestPasswordError;
}
