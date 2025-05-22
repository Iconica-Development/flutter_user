import "package:user_repository_interface/src/models/auth_response.dart";
import "package:user_repository_interface/src/models/request_forgot_password_response.dart";

abstract class UserRepositoryInterface {
  Future<AuthResponse> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<RequestPasswordResponse> requestChangePassword({
    required String email,
  });

  Future<AuthResponse> register({
    required Map<String, dynamic> values,
  });

  Future<bool> logout();

  Future<bool> isLoggedIn();

  Future getLoggedInUser();
}
