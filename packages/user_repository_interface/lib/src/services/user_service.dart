import "package:user_repository_interface/src/interfaces/user_repository_interface.dart";
import "package:user_repository_interface/src/local/local_user_repository.dart";
import "package:user_repository_interface/src/models/login_response.dart";
import "package:user_repository_interface/src/models/registration_reponse.dart";
import "package:user_repository_interface/src/models/request_forgot_password_response.dart";

class UserService {
  UserService({
    UserRepositoryInterface? userRepository,
  }) : userRepository = userRepository ?? LocalUserRepository();

  final UserRepositoryInterface userRepository;

  Future<LoginResponse> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      userRepository.loginWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<RequestPasswordResponse> requestChangePassword({
    required String email,
  }) =>
      userRepository.requestChangePassword(email: email);

  Future<RegistrationResponse> register({
    required Map<String, dynamic> values,
  }) =>
      userRepository.register(values: values);

  Future<bool> logout() => userRepository.logout();

  Future<bool> isLoggedIn() => userRepository.isLoggedIn();

  Future getLoggedInUser() => userRepository.getLoggedInUser();
}
