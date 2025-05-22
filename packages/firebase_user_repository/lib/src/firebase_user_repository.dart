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

  /// Maps a [FirebaseAuthException] to a custom [AuthException].
  AuthException _mapFirebaseAuthException(FirebaseAuthException e) =>
      switch (e.code) {
        "invalid-email" => InvalidEmailError(code: e.code, message: e.message),
        "user-disabled" => UserDisabledError(code: e.code, message: e.message),
        "user-not-found" => UserNotFoundError(code: e.code, message: e.message),
        "wrong-password" =>
          WrongPasswordError(code: e.code, message: e.message),
        "email-already-in-use" =>
          EmailAlreadyInUseError(code: e.code, message: e.message),
        "operation-not-allowed" =>
          OperationNotAllowedError(code: e.code, message: e.message),
        "weak-password" => WeakPasswordError(code: e.code, message: e.message),
        "too-many-requests" =>
          TooManyRequestsError(code: e.code, message: e.message),
        "network-request-failed" =>
          NetworkError(code: e.code, message: e.message),
        "invalid-credential" =>
          InvalidCredentialError(code: e.code, message: e.message),
        "account-exists-with-different-credential" =>
          AccountExistsWithDifferentCredentialError(
            code: e.code,
            message: e.message,
          ),
        "invalid-verification-code" =>
          InvalidVerificationCodeError(code: e.code, message: e.message),
        "invalid-verification-id" =>
          InvalidVerificationIdError(code: e.code, message: e.message),
        "requires-recent-login" =>
          RequiresRecentLoginError(code: e.code, message: e.message),
        _ => GenericAuthError(code: e.code, message: e.message),
      };
}
