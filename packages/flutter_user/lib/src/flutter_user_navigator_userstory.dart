import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_user/flutter_user.dart";
import "package:flutter_user/src/models/auth_error_details.dart";

class FlutterUserNavigatorUserstory extends StatefulWidget {
  const FlutterUserNavigatorUserstory({
    this.afterLoginScreen,
    this.afterRegistration,
    this.userService,
    this.options,
    super.key,
  });

  /// The options for the user story.
  /// This includes the login options, registration options and forgot password
  /// options.
  final FlutterUserOptions? options;

  /// The user service to use for authentication and registration.
  final UserService? userService;

  /// Provide a widget to push after login is successful.
  /// If not provided, nothing will happen and you will need to handle the
  /// navigation yourself through the [afterLogin] callback in the
  /// [FlutterUserOptions].
  final Widget? afterLoginScreen;

  /// A callback function executed after successful registration.
  final VoidCallback? afterRegistration;

  @override
  State<FlutterUserNavigatorUserstory> createState() =>
      _FlutterUserNavigatorUserstoryState();
}

class _FlutterUserNavigatorUserstoryState
    extends State<FlutterUserNavigatorUserstory> {
  late UserService userService;
  late FlutterUserOptions options;

  @override
  void initState() {
    userService = widget.userService ?? UserService();
    options = widget.options ?? FlutterUserOptions();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FlutterUserNavigatorUserstory oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.options != oldWidget.options) {
      setState(() {
        options = widget.options ?? FlutterUserOptions();
      });
    }

    if (widget.userService != oldWidget.userService) {
      setState(() {
        userService = widget.userService ?? UserService();
      });
    }
  }

  @override
  Widget build(BuildContext context) => _loginScreen();

  Widget _loginScreen() {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var loginOptions = options.loginOptions;
    var loginTranslations = loginOptions.translations;

    var title = Text(
      loginTranslations.loginTitle,
      style: textTheme.headlineLarge,
    );
    var subtitle = Text(loginTranslations.loginSubtitle ?? "");

    FutureOr<void> onLogin(String email, String password) async {
      await options.beforeLogin?.call(email, password);
      if (!mounted) return;
      unawaited(showLoadingIndicator(context));
      try {
        await userService.loginWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on AuthException catch (e) {
        if (!mounted) return;
        Navigator.of(context, rootNavigator: true).pop();
        if (!context.mounted) return;
        var authErrorDetails = options.authExceptionFormatter.format(e);
        await errorScaffoldMessenger(context, authErrorDetails);
        return;
      }

      await options.afterLogin?.call();

      var onboardingUser = await options.onBoardedUser?.call();
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();

      if (options.useOnboarding && onboardingUser?.onboarded == false) {
        await push(
          Onboarding(
            onboardingFinished: (results) async {
              await options.onOnboardingComplete?.call(results);
              if (!mounted || !context.mounted) return;
              Navigator.of(context).pop();
              await pushReplacementIfNotNull(widget.afterLoginScreen);
            },
          ),
        );
      } else {
        if (!context.mounted) return;
        await pushReplacementIfNotNull(widget.afterLoginScreen);
      }
    }

    return EmailPasswordLoginForm(
      title: title,
      subtitle: subtitle,
      options: options.loginOptions,
      onLogin: onLogin,
      onForgotPassword: (email, ctx) async {
        await options.onForgotPassword?.call(email, ctx) ??
            await push(_forgotPasswordScreen());
      },
      onRegister: (email, password, context) async {
        await options.onRegister?.call(email, password, context) ??
            await push(_registrationScreen());
      },
    );
  }

  Widget _forgotPasswordScreen() {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var forgotOptions = options.forgotPasswordOptions;
    var forgotTranslations = forgotOptions.translations;

    var title = Text(
      forgotTranslations.forgotPasswordTitle,
      style: textTheme.headlineLarge,
    );

    var description = Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 32),
      child: Text(
        forgotTranslations.forgotPasswordDescription,
        textAlign: TextAlign.center,
      ),
    );

    FutureOr<void> onRequestForgotPassword(String email) async {
      if (options.onRequestForgotPassword != null) {
        await options.onRequestForgotPassword!(email);
        return;
      }
      unawaited(showLoadingIndicator(context));

      try {
        var response = await userService.requestChangePassword(email: email);
        if (!mounted) return;
        Navigator.of(context).pop();
        if (response.requestSuccesfull) {
          await pushReplacementIfNotNull(_forgotPasswordSuccessScreen());
        } else {
          await push(_forgotPasswordUnsuccessfullScreen());
        }
      } on AuthException catch (_) {
        if (!mounted) return;
        Navigator.of(context).pop();
        await push(_forgotPasswordUnsuccessfullScreen());
        return;
      }
    }

    return ForgotPasswordForm(
      title: title,
      description: description,
      loginOptions: options.loginOptions,
      forgotPasswordOptions: options.forgotPasswordOptions,
      onRequestForgotPassword: onRequestForgotPassword,
    );
  }

  Widget _forgotPasswordSuccessScreen() => ForgotPasswordSuccess(
        translations: options.forgotPasswordOptions.translations,
        onRequestForgotPassword: () async {
          await options.onForgotPasswordSuccess?.call() ??
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
        },
      );

  Widget _forgotPasswordUnsuccessfullScreen() => ForgotPasswordUnsuccessfull(
        translations: options.forgotPasswordOptions.translations,
        onPressed: () async {
          await options.onForgotPasswordUnsuccessful?.call() ??
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
        },
      );

  Widget _registrationScreen() => RegistrationScreen(
        registrationOptions: options.registrationOptions,
        userService: userService,
        onError: (error) async {
          var errorDetails = options.authExceptionFormatter.format(error);

          if (options.onRegistrationError != null) {
            return options.onRegistrationError!(error, errorDetails);
          }
          await push(
            _registrationUnsuccessfullScreen(
              errorDetails,
            ),
          );

          if (error is WeakPasswordError) return 1;

          if (error is EmailAlreadyInUseError) return 0;

          return null;
        },
        afterRegistration: () async {
          options.afterRegistration?.call() ??
              await pushReplacementIfNotNull(_registrationSuccessScreen());
        },
      );

  Widget _registrationSuccessScreen() => RegistrationSuccess(
        registrationOptions: options.registrationOptions,
        onPressed: () async {
          await options.afterRegistrationSuccess?.call() ??
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
        },
      );

  Widget _registrationUnsuccessfullScreen(AuthErrorDetails errorDetails) =>
      RegistrationUnsuccessfull(
        registrationOptions: options.registrationOptions,
        onPressed: () async {
          await options.afterRegistrationUnsuccessful?.call() ??
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
        },
        errorDetails: errorDetails,
      );

  Future<void> push(Widget screen) async {
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  /// Pushes a new screen and replaces the current one if the provided screen is
  ///  not null.
  Future<void> pushReplacementIfNotNull(Widget? screen) async {
    if (!context.mounted || screen == null) return;
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
