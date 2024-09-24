// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter/material.dart";

/// An abstract class representing a field in a Flutter form.
///
/// [T] represents the type of value stored in the field.
abstract class AuthField<T> {
  /// Constructs an [AuthField] object.
  ///
  /// [name] specifies the name of the field.
  ///
  /// [value] specifies the initial value of the field.
  ///
  /// [onValueChanged] is a callback function triggered when the
  /// value of the field changes (optional).
  ///
  /// [title] specifies the title widget of the field (optional).
  ///
  /// [validators] defines a list of validation
  /// functions for the field (optional).
  AuthField({
    required this.name,
    required this.value,
    this.onValueChanged,
    this.title,
    this.validators = const [],
  });

  /// The name of the field.
  final String name;

  /// The initial value of the field.
  T value;

  /// A callback function triggered when the value of the field changes.
  final Function(T)? onValueChanged;

  /// The title widget of the field.
  final Widget? title;

  /// A list of validation functions for the field.
  List<String? Function(T?)> validators;

  /// Builds the widget representing the field.
  ///
  /// [context] The build context.
  ///
  /// [onValueChanged] A function to be called when
  /// the value of the field changes.
  Widget build(BuildContext context, Function onValueChanged);
}
