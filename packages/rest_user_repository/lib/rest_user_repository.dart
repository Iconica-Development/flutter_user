import "dart:async";
import "dart:convert";

import "package:dart_api_service/dart_api_service.dart";
import "package:user_repository_interface/user_repository_interface.dart";

class _TokenAuthService extends AuthenticationService<TokenAuthCredentials> {
  String? _token;

  set token(String? newToken) => _token = newToken;
  void clearToken() => _token = null;
  bool get hasToken => _token != null;

  @override
  FutureOr<TokenAuthCredentials> getCredentials() {
    if (!hasToken) {
      throw const RequiresRecentLoginError(
        message: "User is not authenticated.",
      );
    }
    return TokenAuthCredentials(token: _token!);
  }
}

/// An implementation of [UserRepositoryInterface] that uses a REST API.
class RestUserRepository extends HttpApiService<JsonObject>
    implements UserRepositoryInterface {
  /// Creates an instance of the REST user repository.
  ///
  /// Requires the [baseUrl] for the API endpoints.
  RestUserRepository({
    required super.baseUrl, // Pass baseUrl to HttpApiService
    super.client,
    this.apiPrefix = "",
  })  : _authService = _TokenAuthService(),
        super(
          authenticationService: _TokenAuthService(),
          defaultHeaders: const {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          apiResponseConverter: const MapJsonResponseConverter(),
        );

  final _TokenAuthService _authService;

  /// The prefix for the API endpoints, allowing for versioning
  /// or path adjustments.
  final String apiPrefix;

  /// The base endpoint for all API calls within this repository,
  /// incorporating the [apiPrefix].
  Endpoint<JsonObject, JsonObject> get _baseEndpoint => endpoint(apiPrefix);

  /// Logs in a user with the provided [email] and [password].
  ///
  /// On a successful login, it returns an [AuthResponse] and stores the
  /// authentication token. Throws an [AuthException] on failure.
  @override
  Future<AuthResponse> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var converter =
          ModelJsonResponseConverter<AuthResponse, Map<String, dynamic>>(
        deserialize: (json) => AuthResponse(userObject: json["user"]),
        serialize: (body) => body,
      );
      var endpoint =
          _baseEndpoint.child("/auth/token").withConverter(converter);

      var response = await endpoint.post(
        requestModel: {"email": email, "password": password},
      );

      var userMap = response.result?.userObject as Map<String, dynamic>?;
      _authService.token = userMap?["token"] as String?;

      return response.result!;
    } on ApiException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Registers a new user with the given [values].
  ///
  /// On a successful registration, it returns an [AuthResponse] and stores
  /// the authentication token. Throws an [AuthException] on failure.
  @override
  Future<AuthResponse> register({
    required Map<String, dynamic> values,
  }) async {
    try {
      var converter =
          ModelJsonResponseConverter<AuthResponse, Map<String, dynamic>>(
        deserialize: (json) => AuthResponse(userObject: json["user"]),
        serialize: (body) => body,
      );
      var endpoint = _baseEndpoint.child("/user").withConverter(converter);

      var response = await endpoint.post(requestModel: values);

      var userMap = response.result?.userObject as Map<String, dynamic>?;
      _authService.token = userMap?["token"] as String?;

      return response.result!;
    } on ApiException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Requests a password change for the user associated with the [email].
  ///
  /// Returns a [RequestPasswordResponse] indicating if the request was
  /// successful.
  @override
  Future<RequestPasswordResponse> requestChangePassword({
    required String email,
  }) async {
    try {
      var converter = ModelJsonResponseConverter<RequestPasswordResponse,
          Map<String, dynamic>>(
        deserialize: (json) => RequestPasswordResponse(
          requestSuccesfull: json["success"] ?? false,
        ),
        serialize: (body) => body,
      );
      var endpoint = _baseEndpoint
          .child("/user/password-reset/request")
          .withConverter(converter);

      var response = await endpoint.post(requestModel: {"email": email});
      return response.statusCode == 200
          ? const RequestPasswordResponse(requestSuccesfull: true)
          : response.result!;
    } on ApiException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Fetches the profile of the currently logged-in user.
  ///
  /// Throws a [RequiresRecentLoginError] if the user is not authenticated.
  @override
  Future getLoggedInUser() async {
    try {
      var endpoint = _baseEndpoint.child("/users/me").authenticate();
      var response = await endpoint.get();
      return jsonDecode(response.inner.body);
    } on ApiException catch (e) {
      throw _handleAuthError(e);
    }
  }

  /// Checks if a user is currently logged in.
  @override
  Future<bool> isLoggedIn() async => _authService.hasToken;

  /// Logs the current user out by clearing the stored authentication token.
  @override
  Future<bool> logout() async {
    _authService.clearToken();
    return true;
  }

  AuthException _handleAuthError(ApiException e) {
    var message = _getErrorMessage(e.inner.body);
    return switch (e.statusCode) {
      400 => InvalidCredentialError(message: message ?? "Invalid request."),
      401 => WrongPasswordError(message: message ?? "Incorrect credentials."),
      403 => UserDisabledError(message: message ?? "User account is disabled."),
      404 => UserNotFoundError(message: message ?? "User not found."),
      409 =>
        EmailAlreadyInUseError(message: message ?? "Email is already in use."),
      429 => TooManyRequestsError(message: message ?? "Too many requests."),
      _ => GenericAuthError(message: message ?? "An unknown error occurred."),
    };
  }

  String? _getErrorMessage(String body) {
    try {
      return (jsonDecode(body) as Map<String, dynamic>)["message"] as String?;
    } on Exception {
      return null;
    }
  }
}
