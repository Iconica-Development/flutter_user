import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_accessibility/flutter_accessibility.dart";
import "package:flutter_user/src/models/forgot_password/forgot_password_options.dart";
import "package:flutter_user/src/models/login/login_options.dart";
import "package:flutter_user/src/screens/email_password_login_form.dart";

class ForgotPasswordForm extends StatefulWidget {
  /// Constructs a [ForgotPasswordForm] widget.
  ///
  /// [options]: The options for configuring the forgot password form.
  /// [onRequestForgotPassword]: Callback function for requesting
  /// password reset.
  /// [title]: Widget to display title.
  /// [description]: Widget to display description.
  const ForgotPasswordForm({
    required this.onRequestForgotPassword,
    this.loginOptions = const LoginOptions(),
    this.forgotPasswordOptions = const ForgotPasswordOptions(),
    this.title,
    this.description,
    super.key,
  });

  final LoginOptions loginOptions;
  final ForgotPasswordOptions forgotPasswordOptions;

  final Widget? title;
  final Widget? description;

  final FutureOr<void> Function(String email) onRequestForgotPassword;

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _currentEmail = widget.loginOptions.initialEmail;
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  final ValueNotifier<bool> _formValid = ValueNotifier(false);

  String _currentEmail = "";

  void _updateCurrentEmail(String email) {
    _currentEmail = email;
    _validate();
  }

  void _validate() {
    late var isValid =
        widget.loginOptions.validations.validateEmail(_currentEmail) == null;
    if (isValid != _formValid.value) {
      _formValid.value = isValid;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var loginoptions = widget.loginOptions;
    var forgotPasswordOptions = widget.forgotPasswordOptions;

    return Scaffold(
      backgroundColor: forgotPasswordOptions.forgotPasswordBackgroundColor,
      appBar: forgotPasswordOptions.forgotPasswordCustomAppBar ??
          AppBar(
            backgroundColor: const Color(0xffFAF9F6),
          ),
      body: Padding(
        padding: forgotPasswordOptions.forgotPasswordScreenPadding.padding,
        child: CustomScrollView(
          physics: const ScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Column(
                children: [
                  if (forgotPasswordOptions
                          .forgotPasswordSpacerOptions.spacerBeforeTitle !=
                      null) ...[
                    Spacer(
                      flex: forgotPasswordOptions
                          .forgotPasswordSpacerOptions.spacerBeforeTitle!,
                    ),
                  ],
                  Align(
                    alignment: Alignment.topCenter,
                    child: wrapWithDefaultStyle(
                      widget.title,
                      theme.textTheme.displaySmall,
                    ),
                  ),
                  if (forgotPasswordOptions
                          .forgotPasswordSpacerOptions.spacerAfterTitle !=
                      null) ...[
                    Spacer(
                      flex: forgotPasswordOptions
                          .forgotPasswordSpacerOptions.spacerAfterTitle!,
                    ),
                  ],
                  Align(
                    alignment: Alignment.topCenter,
                    child: wrapWithDefaultStyle(
                      widget.description,
                      theme.textTheme.bodyMedium?.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ),
                  if (forgotPasswordOptions
                          .forgotPasswordSpacerOptions.spacerAfterDescription !=
                      null) ...[
                    Spacer(
                      flex: forgotPasswordOptions
                          .forgotPasswordSpacerOptions.spacerAfterDescription!,
                    ),
                  ],
                  Expanded(
                    flex: forgotPasswordOptions
                        .forgotPasswordSpacerOptions.formFlexValue,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: forgotPasswordOptions.maxFormWidth,
                      ),
                      child: Form(
                        key: _formKey,
                        child: AutofillGroup(
                          child: Align(
                            alignment: Alignment.center,
                            child: loginoptions.emailInputContainerBuilder(
                              CustomSemantics(
                                identifier: forgotPasswordOptions
                                    .accessibilityIdentifiers
                                    .emailTextFieldIdentifier,
                                child: TextFormField(
                                  autofillHints: const [AutofillHints.email],
                                  textAlign: loginoptions.emailTextAlign,
                                  focusNode: _focusNode,
                                  onChanged: _updateCurrentEmail,
                                  validator:
                                      loginoptions.validations.validateEmail,
                                  initialValue: loginoptions.initialEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  style: loginoptions.emailTextStyle,
                                  decoration: loginoptions.emailDecoration,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (forgotPasswordOptions
                          .forgotPasswordSpacerOptions.spacerBeforeButton !=
                      null) ...[
                    Spacer(
                      flex: forgotPasswordOptions
                          .forgotPasswordSpacerOptions.spacerBeforeButton!,
                    ),
                  ],
                  AnimatedBuilder(
                    animation: _formValid,
                    builder: (context, snapshot) => Align(
                      child: CustomSemantics(
                        identifier: forgotPasswordOptions
                            .accessibilityIdentifiers
                            .requestForgotPasswordButtonIdentifier,
                        child: forgotPasswordOptions
                            .requestForgotPasswordButtonBuilder(
                          context,
                          () async {
                            _formKey.currentState?.validate();
                            if (_formValid.value) {
                              widget.onRequestForgotPassword(_currentEmail);
                            }
                          },
                          !_formValid.value,
                          () {
                            _formKey.currentState?.validate();
                          },
                          forgotPasswordOptions,
                        ),
                      ),
                    ),
                  ),
                  if (forgotPasswordOptions
                          .forgotPasswordSpacerOptions.spacerAfterButton !=
                      null) ...[
                    Spacer(
                      flex: forgotPasswordOptions
                          .forgotPasswordSpacerOptions.spacerAfterButton!,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
