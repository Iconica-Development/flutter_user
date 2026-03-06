// SPDX-FileCopyrightText: 2025 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter/material.dart";
import "package:flutter_user/src/models/registration/auth/auth_field.dart";

/// A field for capturing text inputs in a Flutter form.
///
/// Extends [AuthField].
class AuthTextField extends AuthField {
  /// Constructs an [AuthTextField] object.
  ///
  /// [name] specifies the name of the field.
  ///
  /// [textEditingController] controller for the text input (optional).
  ///
  /// [title] specifies the title widget of the field (optional).
  ///
  /// [validators] defines a list of validation
  /// functions for the field (optional).
  ///
  /// [value] specifies the initial value of the
  /// field (default is an empty string).
  ///
  /// [textStyle] defines the text style for the text input.
  ///
  /// [onChange] is a callback function triggered
  /// when the value of the field changes.
  ///
  /// [textFieldDecoration] defines the decoration
  /// for the text input field (optional).
  ///
  /// [padding] defines the padding around the text
  /// input field (default is EdgeInsets.all(8.0)).
  AuthTextField({
    required super.name,
    TextEditingController? textEditingController,
    super.title,
    super.validators = const [],
    super.value = "",
    this.textStyle,
    this.onChange,
    this.textFieldDecoration,
    this.padding = const EdgeInsets.all(8.0),
    this.textInputType,
  }) {
    textController =
        textEditingController ?? TextEditingController(text: value);
  }

  /// The controller for the text input.
  late TextEditingController textController;

  /// The text style for the text input.
  final TextStyle? textStyle;

  /// A callback function triggered when the value of the field changes.
  final Function(String value)? onChange;

  /// The decoration for the text input field.
  final InputDecoration? textFieldDecoration;

  /// The padding around the text input field.
  final EdgeInsets padding;

  /// The type of text input.
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context, Function onValueChanged) => Padding(
        padding: padding,
        child: TextFormField(
          keyboardType: textInputType,
          style: textStyle,
          decoration: textFieldDecoration,
          controller: textController,
          onChanged: (v) {
            value = v;
            onChange?.call(value);
            // ignore: avoid_dynamic_calls
            onValueChanged();
          },
          validator: (value) {
            for (var validator in validators) {
              var output = validator(value);
              if (output != null) {
                return output;
              }
            }

            return null;
          },
        ),
      );
}
