// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:user_repository_interface/user_repository_interface.dart";

/// A [LoginResponse] object is returned from a login attempt.
/// If the login was successful, [loginSuccessful] will be true and
/// [userObject] will contain the user object. If the login was not
/// successful, [loginSuccessful] will be false and [loginError] will
/// contain an [Error] object with the error title and message.
class LoginResponse<T> {
  const LoginResponse({
    required this.loginSuccessful,
    required this.userObject,
    this.loginError,
  });
  final bool loginSuccessful;

  final T? userObject;
  final UserError? loginError;
}
