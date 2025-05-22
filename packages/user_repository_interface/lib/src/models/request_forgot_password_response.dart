/// A [RequestPasswordResponse] object is returned from a password
/// reset request. If the request was successful, [requestSuccesfull]
/// will be true.
class RequestPasswordResponse<T> {
  const RequestPasswordResponse({
    required this.requestSuccesfull,
  });
  final bool requestSuccesfull;
}
