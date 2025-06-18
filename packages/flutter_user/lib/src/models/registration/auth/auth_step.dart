// SPDX-FileCopyrightText: 2025 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter_user/src/models/registration/auth/auth_field.dart";

/// A step in the authentication process.
class AuthStep {
  /// Constructs an [AuthStep] object.
  const AuthStep({
    required this.fields,
  });

  /// The fields in the step.
  final List<AuthField> fields;
}
