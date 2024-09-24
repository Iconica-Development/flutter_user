// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter/material.dart";

/// An action that can be performed during authentication.
class AuthAction {
  /// Constructs an [AuthAction] object.
  AuthAction({
    required this.title,
    required this.onPress,
  });

  /// The title of the action.
  final String title;

  /// A callback function triggered when the action is pressed.
  final VoidCallback onPress;
}
