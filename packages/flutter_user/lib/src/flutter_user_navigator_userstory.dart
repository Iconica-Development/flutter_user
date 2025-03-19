import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_user/flutter_user.dart";
import "package:user_repository_interface/user_repository_interface.dart";

class FlutterUserNavigatorUserstory extends StatefulWidget {
  const FlutterUserNavigatorUserstory({
    required this.afterLoginScreen,
    this.userService,
    this.options,
    super.key,
  });

  final FlutterUserOptions? options;
  final UserService? userService;
  final Widget afterLoginScreen;

  @override
  State<FlutterUserNavigatorUserstory> createState() =>
      _FlutterUserNavigatorUserstoryState();
}

class _FlutterUserNavigatorUserstoryState
    extends State<FlutterUserNavigatorUserstory> {
  UserService? userService;
  FlutterUserOptions? options;

  @override
  void initState() {
    userService = widget.userService ?? UserService();
    options = widget.options ?? FlutterUserOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _loginScreen();

  Widget _loginScreen() => EmailPasswordLoginForm(
        options: options!.loginOptions,
        onLogin: (email, password) async {
          await options!.beforeLogin?.call(email, password);
          // ignore: use_build_context_synchronously
          unawaited(showLoadingIndicator(context));
          var loginResponse = await userService!.loginWithEmailAndPassword(
            email: email,
            password: password,
          );

          if (!loginResponse.loginSuccessful) {
            if (context.mounted) {
              // ignore: use_build_context_synchronously
              await errorScaffoldMessenger(context, loginResponse);
            }
            return;
          }
          await options!.afterLogin?.call();

          if (loginResponse.loginSuccessful) {
            var onboardingUser = await options!.onBoardedUser?.call();
            if (context.mounted) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              if (options!.useOnboarding &&
                  onboardingUser?.onboarded == false) {
                await push(
                  Onboarding(
                    onboardingFinished: (results) async {
                      await options!.onOnboardingComplete?.call(results);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                      await pushReplacement(widget.afterLoginScreen);
                    },
                  ),
                );
              } else {
                await pushReplacement(widget.afterLoginScreen);
              }
            }
          }
        },
        onForgotPassword: (email, ctx) async {
          await options!.onForgotPassword?.call(email, ctx) ??
              await push(_forgotPasswordScreen());
        },
        onRegister: (email, password, context) async {
          await options!.onRegister?.call(email, password, context) ??
              await push(_registrationScreen());
        },
      );

  Widget _forgotPasswordScreen() {
    var theme = Theme.of(context);
    var title = Text(
      options!.forgotPasswordOptions.translations.forgotPasswordTitle,
      style: theme.textTheme.headlineLarge,
    );

    var description = Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 32),
      child: Text(
        options!.forgotPasswordOptions.translations.forgotPasswordDescription,
        textAlign: TextAlign.center,
      ),
    );

    return ForgotPasswordForm(
      title: title,
      description: description,
      loginOptions: options!.loginOptions,
      onRequestForgotPassword: (email) async {
        if (options!.onRequestForgotPassword != null) {
          await options!.onRequestForgotPassword!(email);
          return;
        }
        unawaited(showLoadingIndicator(context));

        var requestPasswordReponse =
            await userService!.requestChangePassword(email: email);

        if (requestPasswordReponse.requestSuccesfull) {
          if (context.mounted) {
            await pushReplacement(_forgotPasswordSuccessScreen());
          }
        } else {
          if (context.mounted) {
            await push(_forgotPasswordUnsuccessfullScreen());
          }
        }
      },
    );
  }

  Widget _forgotPasswordSuccessScreen() => ForgotPasswordSuccess(
        translations: options!.forgotPasswordOptions.translations,
        onRequestForgotPassword: () async {
          await options!.onForgotPasswordSuccess?.call() ??
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
        },
      );

  Widget _forgotPasswordUnsuccessfullScreen() => ForgotPasswordUnsuccessfull(
        translations: options!.forgotPasswordOptions.translations,
        onPressed: () async {
          await options!.onForgotPasswordUnsuccessful?.call() ??
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
        },
      );

  Widget _registrationScreen() => RegistrationScreen(
        registrationOptions: options!.registrationOptions!,
        userService: userService!,
        onError: (error) async {
          if (options!.onRegistrationError != null) {
            return options!
                .onRegistrationError!(error ?? "Something went wrong");
          }
          await push(
            _registrationUnsuccessfullScreen(
              error ?? "Something went wrong",
            ),
          );
          var isPasswordError = error?.contains("weak-password") ?? false;
          var isEmailError = error?.contains("email-already-in-use") ?? false;
          if (isPasswordError) {
            return 1;
          }
          if (isEmailError) {
            return 2;
          }

          return null;
        },
        afterRegistration: () async {
          options!.afterRegistration?.call() ??
              await pushReplacement(_registrationSuccessScreen());
        },
      );

  Widget _registrationSuccessScreen() => RegistrationSuccess(
        registrationOptions: options!.registrationOptions!,
        onPressed: () async {
          await options!.afterRegistrationSuccess?.call() ??
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
        },
      );

  Widget _registrationUnsuccessfullScreen(String error) =>
      RegistrationUnsuccessfull(
        registrationOptions: options!.registrationOptions!,
        onPressed: () async {
          await options!.afterRegistrationUnsuccessful?.call() ??
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
        },
        error: error,
      );

  Future<void> push(Widget screen) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  Future<void> pushReplacement(Widget screen) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
