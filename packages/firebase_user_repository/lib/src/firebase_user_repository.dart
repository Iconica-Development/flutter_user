import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:user_repository_interface/user_repository_interface.dart";

class FirebaseUserRepository implements UserRepositoryInterface {
  FirebaseUserRepository({
    this.userCollecton = "users",
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;
  final String userCollecton;

  @override
  Future<AuthResponse> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthResponse(
        userObject: userCredential.user,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  @override
  Future<AuthResponse> register({
    required Map<String, dynamic> values,
  }) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: values["email"],
        password: values["password"],
      );
      values.remove("password");

      await FirebaseFirestore.instance
          .collection(userCollecton)
          .doc(userCredential.user!.uid)
          .set(values);

      return AuthResponse(
        userObject: userCredential.user,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  @override
  Future<RequestPasswordResponse> requestChangePassword({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const RequestPasswordResponse(
        requestSuccesfull: true,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    }
  }

  @override
  Future<bool> logout() async {
    await _firebaseAuth.signOut();
    return true;
  }

  @override
  Future getLoggedInUser() async => _firebaseAuth.currentUser;

  @override
  Future<bool> isLoggedIn() async => _firebaseAuth.currentUser != null;

  AuthException _mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        return InvalidEmailError(code: e.code, message: e.message);
      case "user-disabled":
        return UserDisabledError(code: e.code, message: e.message);
      case "user-not-found":
        return UserNotFoundError(code: e.code, message: e.message);
      case "wrong-password":
        return WrongPasswordError(code: e.code, message: e.message);
      case "email-already-in-use":
        return EmailAlreadyInUseError(code: e.code, message: e.message);
      case "operation-not-allowed":
        return OperationNotAllowedError(code: e.code, message: e.message);
      case "weak-password":
        return WeakPasswordError(code: e.code, message: e.message);
      case "too-many-requests":
        return TooManyRequestsError(code: e.code, message: e.message);
      case "network-request-failed":
        return NetworkError(code: e.code, message: e.message);
      case "invalid-credential":
        return InvalidCredentialError(code: e.code, message: e.message);
      case "account-exists-with-different-credential":
        return AccountExistsWithDifferentCredentialError(
          code: e.code,
          message: e.message,
        );
      case "invalid-verification-code":
        return InvalidVerificationCodeError(code: e.code, message: e.message);
      case "invalid-verification-id":
        return InvalidVerificationIdError(code: e.code, message: e.message);
      case "requires-recent-login":
        return RequiresRecentLoginError(code: e.code, message: e.message);
      default:
        return GenericAuthError(code: e.code, message: e.message);
    }
  }
}
