import "package:user_repository_interface/user_repository_interface.dart";

class UserService {
  UserService({
    UserRepositoryInterface? userRepository,
  }) : userRepository = userRepository ?? LocalUserRepository();

  final UserRepositoryInterface userRepository;

  Future<AuthResponse> loginWithEmailAndPassword({
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

  Future<AuthResponse> register({
    required Map<String, dynamic> values,
  }) =>
      userRepository.register(values: values);

  Future<bool> logout() => userRepository.logout();

  Future<bool> isLoggedIn() => userRepository.isLoggedIn();

  Future getLoggedInUser() => userRepository.getLoggedInUser();
}
