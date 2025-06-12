import "package:user_repository_interface/user_repository_interface.dart";

class LocalUserRepository implements UserRepositoryInterface {
  LocalUserRepository();

  bool loggedIn = false;
  dynamic userObject;

  @override
  Future<AuthResponse> register({
    required Map<String, dynamic> values,
  }) async =>
      AuthResponse(
        userObject: userObject,
      );

  @override
  Future<RequestPasswordResponse> requestChangePassword({
    required String email,
  }) async =>
      const RequestPasswordResponse(
        requestSuccesfull: true,
      );

  @override
  Future<AuthResponse> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    loggedIn = true;
    userObject = {
      "name": "John",
      "email": email,
      "password": password,
    };
    return AuthResponse(
      userObject: userObject,
    );
  }

  @override
  Future<bool> logout() async {
    userObject = null;
    loggedIn = false;
    return true;
  }

  @override
  Future getLoggedInUser() async => userObject;

  @override
  Future<bool> isLoggedIn() async => loggedIn;
}
