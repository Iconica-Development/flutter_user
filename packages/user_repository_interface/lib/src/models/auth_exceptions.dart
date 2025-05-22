// SPDX-FileCopyrightText: 2025 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

abstract class AuthException implements Exception {
  const AuthException({
    this.code,
    this.message,
  });
  final String? code;
  final String? message;

  @override
  String toString() => "$code: $message";
}

class InvalidEmailError extends AuthException {
  const InvalidEmailError({super.code, super.message});
}

class UserDisabledError extends AuthException {
  const UserDisabledError({super.code, super.message});
}

class UserNotFoundError extends AuthException {
  const UserNotFoundError({super.code, super.message});
}

class WrongPasswordError extends AuthException {
  const WrongPasswordError({super.code, super.message});
}

class EmailAlreadyInUseError extends AuthException {
  const EmailAlreadyInUseError({super.code, super.message});
}

class OperationNotAllowedError extends AuthException {
  const OperationNotAllowedError({super.code, super.message});
}

class WeakPasswordError extends AuthException {
  const WeakPasswordError({super.code, super.message});
}

class TooManyRequestsError extends AuthException {
  const TooManyRequestsError({super.code, super.message});
}

class NetworkError extends AuthException {
  const NetworkError({super.code, super.message});
}

class InvalidCredentialError extends AuthException {
  const InvalidCredentialError({super.code, super.message});
}

class AccountExistsWithDifferentCredentialError extends AuthException {
  const AccountExistsWithDifferentCredentialError({super.code, super.message});
}

class InvalidVerificationCodeError extends AuthException {
  const InvalidVerificationCodeError({super.code, super.message});
}

class InvalidVerificationIdError extends AuthException {
  const InvalidVerificationIdError({super.code, super.message});
}

class RequiresRecentLoginError extends AuthException {
  const RequiresRecentLoginError({super.code, super.message});
}

class GenericAuthError extends AuthException {
  const GenericAuthError({super.code, super.message});
}
