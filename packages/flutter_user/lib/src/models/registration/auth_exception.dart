// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

/// An exception thrown when an authentication error occurs.
class AuthException implements Exception {
  /// Constructs an [AuthException] object.
  AuthException(this.message);

  /// The error message.
  final String message;

  @override
  String toString() => message;
}
