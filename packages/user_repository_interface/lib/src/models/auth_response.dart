// SPDX-FileCopyrightText: 2025 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

/// A [AuthResponse] object is returned with the user object
class AuthResponse<T> {
  const AuthResponse({
    required this.userObject,
  });
  final T? userObject;
}
